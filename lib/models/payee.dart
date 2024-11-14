import 'package:uuid/uuid.dart';
import 'package:zaccount/models/address.dart';

class Payee {
  String id;
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
  String companyName;
  String website;
  int openingBalance;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;

  // Default constructor
  Payee({
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
    required this.address,
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
      'address': address.toMap(),
      'companyName': companyName,
      'website': website,
      'openingBalance': openingBalance,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // JSON deserialization
  factory Payee.fromJson(Map<String, dynamic> json) {
    return Payee(
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
      address: Address.fromMap(json['address']),
      companyName: json['companyName'],
      website: json['website'],
      openingBalance: json['openingBalance'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
