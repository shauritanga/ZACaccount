import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/address.dart';
import 'package:zaccount/models/business_profile.dart';
import 'package:zaccount/models/business_type.dart';
import 'package:zaccount/models/company.dart';
import 'package:zaccount/models/company_profile.dart';
import 'package:zaccount/models/date_of_birth.dart';
import 'package:zaccount/models/individual.dart';

final companyProvider = StateNotifierProvider<CompanyNotifier, Company>((ref) {
  return CompanyNotifier();
});

class CompanyNotifier extends StateNotifier<Company> {
  CompanyNotifier()
      : super(
          Company(
            id: "",
            created: DateTime.now(),
            updated: DateTime.now(),
            individual: Individual(id: FirebaseAuth.instance.currentUser!.uid),
            businessProfile: const BusinessProfile(),
            companyProfile: const CompanyProfile(
              name: "",
              phone: "",
              taxId: "",
              address: Address(
                street: "",
                unitNumber: "",
                city: "",
                country: "",
                zipCode: "",
              ),
            ),
          ),
        );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateName(String name) {
    state = state.copyWith(displayName: name);
  }

  void updateBusinessType(BusinessTypes businessType) {
    state = state.copyWith(businessType: businessType.name);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateCountry(String country) {
    state = state.copyWith(country: country);
  }

  //Business Profile
  void updateBusinessMcc(String mcc) {
    state = state.copyWith(
        businessProfile: state.businessProfile?.copyWith(mcc: mcc));
  }

  void updateBusinessName(String name) {
    state = state.copyWith(
        businessProfile: state.businessProfile?.copyWith(name: name));
  }

  void updateBusinessSupportURL(String supportURL) {
    state = state.copyWith(
        businessProfile:
            state.businessProfile?.copyWith(supportURL: supportURL));
  }

  void updateBusinessSupportAddress(Address supportAddress) {
    state = state.copyWith(
        businessProfile:
            state.businessProfile?.copyWith(supportAddress: supportAddress));
  }

  void updateBusinessSupportEmail(String supportEmail) {
    state = state.copyWith(
        businessProfile:
            state.businessProfile?.copyWith(supportEmail: supportEmail));
  }

  void updateBusinessSupportPhone(String supportPhone) {
    state = state.copyWith(
        businessProfile:
            state.businessProfile?.copyWith(supportPhone: supportPhone));
  }

//Company Profile
  void updateCompanyProfileName(String name) {
    state = state.copyWith(
        companyProfile: state.companyProfile?.copyWith(name: name));
  }

  void updateCompanyProfilePhone(String phone) {
    state = state.copyWith(
        companyProfile: state.companyProfile?.copyWith(phone: phone));
  }

  void updateCompanyProfileTaxId(String taxId) {
    state = state.copyWith(
        companyProfile: state.companyProfile?.copyWith(taxId: taxId));
  }

  void updateCompanyProfileAddress(Address address) {
    state = state.copyWith(
        companyProfile: state.companyProfile?.copyWith(address: address));
  }

  Future<String> addCompanyDetails() async {
    DocumentReference reference =
        await _firestore.collection("companies").add(state.toMap());
    return reference.id;
  }

  void updateIndividualNames(String firstName, String lastName, String email) {
    state = state.copyWith(
      individual: state.individual?.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
    );
  }

  void updateIndividualDOB(DateOfBirth dob) {
    state = state.copyWith(
      individual: state.individual?.copyWith(dob: dob),
    );
  }

  void updateIndividualPhone(String phone) {
    state = state.copyWith(
      individual: state.individual?.copyWith(phone: phone),
    );
  }

  void updateIndividualSSNLast4(String ssnLast4) {
    state = state.copyWith(
      individual: state.individual?.copyWith(ssnLast4: ssnLast4),
    );
  }

  Future<Company?> fetchData() async {
    print("it is called");
    User? user = FirebaseAuth.instance.currentUser;
    late Company company;
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('companies') // Replace with your collection name
          .where('individual.email', isEqualTo: user?.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs[0].data());
        company = Company.fromMap(
            querySnapshot.docs[0].data() as Map<String, dynamic>);
        print(company);
        state = company;
        return company;
      } else {
        state = Company(
          id: "",
          created: DateTime.now(),
          updated: DateTime.now(),
          individual: Individual(id: user!.uid),
          businessProfile: const BusinessProfile(),
          companyProfile: const CompanyProfile(
            name: "",
            phone: "",
            taxId: "",
            address: Address(
              street: "",
              unitNumber: "",
              city: "",
              country: "",
              zipCode: "",
            ),
          ),
        ); //
        return null;
      }
    } catch (e) {
      print(e);
      debugPrint('Error fetching company: $e');
    }
    return company;
  }
}
