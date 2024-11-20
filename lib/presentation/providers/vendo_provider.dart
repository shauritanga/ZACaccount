import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/address.dart';
import 'package:zaccount/models/vendor.dart';
import 'package:zaccount/presentation/providers/staff_provider.dart';

final vendorsFutureProvider = FutureProvider<List<Vendor>>((ref) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await firestore.collection("vendors").get();
  final vendors = snapshot.docs
      .map((doc) => Vendor.fromJson(doc.data() as Map<String, dynamic>, doc.id))
      .toList();
  return vendors;
});

final vendorStreamProvider = StreamProvider<List<Vendor>>((ref) {
  return FirebaseFirestore.instance.collection('vendors').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Vendor.fromDocument(doc)).toList(),
      );
});

final vendorProviderNotifier =
    StateNotifierProvider<VendorNotifier, Vendor>((ref) {
  return VendorNotifier(ref);
});

class VendorNotifier extends StateNotifier<Vendor> {
  VendorNotifier(this.ref)
      : super(
          Vendor(
            address: const Address(
              street: "",
              unitNumber: "",
              city: "",
              country: "",
              zipCode: "",
            ),
          ),
        );

  final Ref ref;

  void updateVendorDetails(
      {String name = "", String display = "", String website = ""}) {
    state = state.copyWith(
        companyName: name, displayName: display, website: website);

    debugPrint(state.id);
  }

  void updateAddressDetails(
      {String street = "",
      String unitNumber = "",
      String city = "",
      String country = "",
      String zipcode = ""}) {
    state = state.copyWith(
      address: Address(
        street: street,
        unitNumber: unitNumber,
        city: city,
        country: country,
        zipCode: zipcode,
      ),
    );
  }

  void updateBankDetails({
    String accountName = "",
    String accountNumber = "",
    String routingNumber = "",
    String nameOnChecks = "",
  }) {
    state = state.copyWith(
      accountName: accountName,
      accountNo: accountNumber,
      routingNo: routingNumber,
      nameOnChecks: nameOnChecks,
    );
  }

  void updateAdditionalDetails({
    double openingBalance = 0,
    String notes = "",
  }) {
    state = state.copyWith(
      openingBalance: openingBalance,
      notes: notes,
    );
  }

  void updateStaff(
      {String firstName = "",
      String lastName = "",
      String email = "",
      String phone = ""}) {
    final staff = ref.read(staffProvider.notifier);
    staff.updatePersonalInfo(
      companyId: state.id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    state = state.copyWith(
        firstName: firstName, lastName: lastName, email: email, phone: phone);
  }

  Future<String> saveVendor(Vendor vendor) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference reference =
        await firestore.collection("vendors").add(state.toJson());

    return reference.id;
  }
}
