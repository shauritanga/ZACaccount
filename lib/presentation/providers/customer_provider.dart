import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/address.dart';
import 'package:zaccount/models/customer.dart';

final customerFutureProvider = FutureProvider<List<Customer>>((ref) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await firestore.collection("customers").get();
  final customers = snapshot.docs
      .map((doc) => Customer.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
  return customers;
});

final customerStreamProvider = StreamProvider<List<Customer>>((ref) {
  return FirebaseFirestore.instance.collection('customers').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Customer.fromDocument(doc)).toList(),
      );
});

final customerProvider =
    StateNotifierProvider<CustomerNotifier, Customer>((ref) {
  return CustomerNotifier();
});

class CustomerNotifier extends StateNotifier<Customer> {
  CustomerNotifier()
      : super(
          Customer(
            firstName: "",
            middleName: "",
            lastName: "",
            displayName: "",
            email: "",
            phone: "",
            shippingAddress: const Address(
              street: "",
              unitNumber: "",
              city: "",
              country: "",
              zipCode: "",
            ),
            billingAddress: const Address(
              street: "",
              unitNumber: "",
              city: "",
              country: "",
              zipCode: "",
            ),
            customerType: "",
            companyName: "",
            website: "",
            openingBalance: 0,
          ),
        );

  final FirebaseFirestore _firesore = FirebaseFirestore.instance;

  void updatePesonalDetails({
    String firstName = "",
    String middleName = "",
    String lastName = "",
    String displayName = "",
    String email = "",
    String phone = "",
  }) {
    state = state.copyWith(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      displayName: displayName,
      email: email,
      phone: phone,
    );
  }

  void updateShppingAddress({
    String street = "",
    String unit = "",
    String city = "",
    String country = "",
    String zipcode = "",
  }) {
    state = state.copyWith(
      shippingAddress: Address(
        street: street,
        unitNumber: unit,
        city: city,
        country: country,
        zipCode: zipcode,
      ),
    );
  }

  void updateAdditionalDetails({
    String company = "",
    String website = "",
    String customerType = "",
    double openingBalance = 0,
    String parentId = "",
  }) {
    state = state.copyWith(
      companyName: company,
      website: website,
      customerType: customerType,
      openingBalance: openingBalance,
      parentCustomerId: parentId,
    );
  }

  Future<String> addCustomer() async {
    DocumentReference reference =
        await _firesore.collection("customers").add(state.toJson());
    return reference.id;
  }
}
