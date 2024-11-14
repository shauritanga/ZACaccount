// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/address.dart';

class Customer {
  final String id;
  final String title;
  final String firstName;
  final String middleName;
  final String lastName;
  final String displayName;
  final String suffix;
  final String email;
  final String phone;
  final String mobileNumber;
  final String faxNumber;
  final Address? shippingAddress;
  final Address? billingAddress;
  final String customerType;
  final bool isSubcustomer;
  final String parentCustomerId;
  final bool billParentCustomer;
  final String companyName;
  final String website;
  final double openingBalance;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Default constructor
  Customer({
    String? id,
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
    this.shippingAddress,
    this.billingAddress,
    this.customerType = '',
    this.isSubcustomer = false,
    this.parentCustomerId = '',
    this.billParentCustomer = false,
    this.companyName = '',
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
      'shippingAddress': shippingAddress?.toMap(),
      'billingAddress': billingAddress?.toMap(),
      'customerType': customerType,
      'isSubcustomer': isSubcustomer,
      'parentCustomerId': parentCustomerId,
      'billParentCustomer': billParentCustomer,
      'companyName': companyName,
      'website': website,
      'openingBalance': openingBalance,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // JSON deserialization
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
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
      shippingAddress: Address.fromMap(json['shippingAddress']),
      billingAddress: Address.fromMap(json['billingAddress']),
      customerType: json['customerType'],
      isSubcustomer: json['isSubcustomer'],
      parentCustomerId: json['parentCustomerId'],
      billParentCustomer: json['billParentCustomer'],
      companyName: json['companyName'],
      website: json['website'],
      openingBalance: json['openingBalance'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory Customer.fromDocument(DocumentSnapshot json) {
    return Customer(
      id: json.id,
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
      shippingAddress: Address.fromMap(json['shippingAddress']),
      billingAddress: Address.fromMap(json['billingAddress']),
      customerType: json['customerType'],
      isSubcustomer: json['isSubcustomer'],
      parentCustomerId: json['parentCustomerId'],
      billParentCustomer: json['billParentCustomer'],
      companyName: json['companyName'],
      website: json['website'],
      openingBalance: json['openingBalance'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to reset to initial values
  void resetToInitialValues() {
    Customer();
  }

  Customer copyWith({
    String? id,
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
    Address? shippingAddress,
    Address? billingAddress,
    String? customerType,
    bool? isSubcustomer,
    String? parentCustomerId,
    bool? billParentCustomer,
    String? companyName,
    String? website,
    double? openingBalance,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
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
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      customerType: customerType ?? this.customerType,
      isSubcustomer: isSubcustomer ?? this.isSubcustomer,
      parentCustomerId: parentCustomerId ?? this.parentCustomerId,
      billParentCustomer: billParentCustomer ?? this.billParentCustomer,
      companyName: companyName ?? this.companyName,
      website: website ?? this.website,
      openingBalance: openingBalance ?? this.openingBalance,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
