import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/address.dart';
import 'package:zaccount/models/store.dart';

final storeStreamProvider = StreamProvider<List<Store>>((ref) {
  return FirebaseFirestore.instance.collection('stores').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Store.fromDocument(doc)).toList(),
      );
});

final storeProvider = StateNotifierProvider<StoreNotifier, Store>((ref) {
  return StoreNotifier();
});

class StoreNotifier extends StateNotifier<Store> {
  StoreNotifier()
      : super(
          Store(
            address: const Address(
                street: "",
                unitNumber: "",
                city: "",
                country: "country",
                zipCode: ""),
          ),
        );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateStoreInformation({
    required String name,
    required String email,
    required String phone,
  }) {
    state = state.copyWith(name: name, email: email, phone: phone);
  }

  void updateAddress(
      {required String street,
      required String unitNumber,
      required String city,
      required String country}) {
    state = state.copyWith(
      address: Address(
          street: street,
          unitNumber: unitNumber,
          city: city,
          country: country,
          zipCode: "00000"),
    );
  }

  Future<String> addStore() async {
    DocumentReference reference =
        await _firestore.collection("stores").add(state.toJson());
    return reference.id;
  }
}
