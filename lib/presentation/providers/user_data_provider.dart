import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/user_detail.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  final String? id;
  final UserDetails? user;

  LocalUser({this.id, this.user});

  LocalUser copyWith({
    String? id,
    UserDetails? user,
  }) {
    return LocalUser(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }
}

class UserNotifier extends StateNotifier<LocalUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UserNotifier() : super(LocalUser(user: const UserDetails()));

  Future<void> getUserData(String email) async {
    QuerySnapshot reference = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();

    if (reference.docs.isEmpty) {
      return;
    }

    state = state.copyWith(
        id: reference.docs[0].id,
        user: UserDetails.fromMap(
            reference.docs[0].data() as Map<String, dynamic>));
  }

  Future<void> addUserData(
      String email, String firstname, String lastname) async {
    DocumentReference reference = await _firestore.collection("users").add(
        UserDetails(email: email, firstName: firstname, lastName: lastname)
            .toMap());

    DocumentSnapshot snapshot = await reference.get();

    state = state.copyWith(
        id: reference.id,
        user: UserDetails.fromMap(snapshot.data() as Map<String, dynamic>));
  }

  void updateNames(String firstname, String lastname) {
    state = state.copyWith(
      user: state.user?.copyWith(firstName: firstname, lastName: lastname),
    );
    print(state.user?.firstName);
  }

  Future<void> updateImage(File image) async {
    Reference storageRef = _storage.ref().child("users").child(state.id!);
    TaskSnapshot snapshot = await storageRef.putFile(image);
    String profilePicUrl = await snapshot.ref.getDownloadURL();
    await _firestore
        .collection("users")
        .doc(state.id)
        .update(({'profilePic': profilePicUrl}));

    state = state.copyWith(user: state.user?.copyWith(imageUrl: profilePicUrl));
  }

  void clearUserData() {
    state = LocalUser();
  }
}
