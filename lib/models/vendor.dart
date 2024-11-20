// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/address.dart';

class Vendor {
  String id;
  String companyName;
  String vendorDisplayName;
  String title;
  String firstName;
  String middleName;
  String lastName;
  String displayName;
  String suffix;
  String email;
  String phone;
  String mobileNumber;
  String faxNumber;
  Address address;
  String nameOnChecks;
  String accountName;
  String accountNo;
  String routingNo;
  String businessIdNo;
  String website;
  double openingBalance;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;

  // Default constructor
  Vendor({
    String? id,
    this.companyName = '',
    this.vendorDisplayName = '',
    this.title = '',
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.displayName = '',
    this.suffix = '',
    this.email = '',
    this.phone = '',
    this.mobileNumber = '',
    this.faxNumber = '',
    required this.address,
    this.nameOnChecks = '',
    this.accountName = '',
    this.accountNo = '',
    this.routingNo = '',
    this.businessIdNo = '',
    this.website = '',
    this.openingBalance = 0,
    this.notes = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'vendorDisplayName': vendorDisplayName,
      'title': title,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'displayName': displayName,
      'suffix': suffix,
      'email': email,
      'phone': phone,
      'mobileNumber': mobileNumber,
      'faxNumber': faxNumber,
      'address': address.toMap(),
      'nameOnChecks': nameOnChecks,
      'accountName': accountName,
      'accountNo': accountNo,
      'routingNo': routingNo,
      'businessIdNo': businessIdNo,
      'website': website,
      'openingBalance': openingBalance,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // JSON deserialization
  factory Vendor.fromJson(Map<String, dynamic> json, String id) {
    return Vendor(
      id: id,
      companyName: json['companyName'],
      vendorDisplayName: json['vendorDisplayName'],
      title: json['title'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      displayName: json['displayName'],
      suffix: json['suffix'],
      email: json['email'],
      phone: json['phone'],
      mobileNumber: json['mobileNumber'],
      faxNumber: json['faxNumber'],
      address: Address.fromMap(json['address']),
      nameOnChecks: json['nameOnChecks'],
      accountName: json['accountName'],
      accountNo: json['accountNo'],
      routingNo: json['routingNo'],
      businessIdNo: json['businessIdNo'],
      website: json['website'],
      openingBalance: json['openingBalance'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory Vendor.fromDocument(DocumentSnapshot json) {
    return Vendor(
      id: json.id,
      companyName: json['companyName'],
      vendorDisplayName: json['vendorDisplayName'],
      title: json['title'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      displayName: json['displayName'],
      suffix: json['suffix'],
      email: json['email'],
      phone: json['phone'],
      mobileNumber: json['mobileNumber'],
      faxNumber: json['faxNumber'],
      address: Address.fromMap(json['address']),
      nameOnChecks: json['nameOnChecks'],
      accountName: json['accountName'],
      accountNo: json['accountNo'],
      routingNo: json['routingNo'],
      businessIdNo: json['businessIdNo'],
      website: json['website'],
      openingBalance: json['openingBalance'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Vendor copyWith({
    String? id,
    String? companyName,
    String? vendorDisplayName,
    String? title,
    String? firstName,
    String? middleName,
    String? lastName,
    String? displayName,
    String? suffix,
    String? email,
    String? phone,
    String? mobileNumber,
    String? faxNumber,
    Address? address,
    String? nameOnChecks,
    String? accountName,
    String? accountNo,
    String? routingNo,
    String? businessIdNo,
    String? website,
    double? openingBalance,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Vendor(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      vendorDisplayName: vendorDisplayName ?? this.vendorDisplayName,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      suffix: suffix ?? this.suffix,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      faxNumber: faxNumber ?? this.faxNumber,
      address: address ?? this.address,
      nameOnChecks: nameOnChecks ?? this.nameOnChecks,
      accountName: accountName ?? this.accountName,
      accountNo: accountNo ?? this.accountNo,
      routingNo: routingNo ?? this.routingNo,
      businessIdNo: businessIdNo ?? this.businessIdNo,
      website: website ?? this.website,
      openingBalance: openingBalance ?? this.openingBalance,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
