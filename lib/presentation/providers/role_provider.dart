import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/custom_permissions.dart';
import 'package:zaccount/models/role.dart';

final roleProvider = StateNotifierProvider<RoleNotifier, Role>((ref) {
  return RoleNotifier();
});

final roleStremProvider = StreamProvider<List<Role>>((ref) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore.collection("roles").snapshots().map((snapshot) =>
      snapshot.docs.map((snap) => Role.fromDocument(snap)).toList());
});

class RoleNotifier extends StateNotifier<Role> {
  RoleNotifier() : super(Role(roleName: "", permissions: CustomPermissions()));

  Future<void> addRole(Role role) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("roles").add(role.toMap());
  }
}
