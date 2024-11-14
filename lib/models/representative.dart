// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zaccount/models/date_of_birth.dart';

class Representative extends Equatable {
  final String id;
  final String address;
  final DateOfBirth? dob;
  final String? email;
  final String? firstName;
  final String? idNumber;
  final String? lastName;
  final String? phone;
  final String? relationshipExecutive;
  final List<String>? relationship;
  final String? ssnLast4;
  final String? verificationDocument;

  const Representative({
    required this.id,
    required this.address,
    required this.dob,
    required this.email,
    required this.firstName,
    required this.idNumber,
    required this.lastName,
    required this.phone,
    required this.relationshipExecutive,
    required this.relationship,
    required this.ssnLast4,
    required this.verificationDocument,
  });

  Representative copyWith({
    String? id,
    String? address,
    DateOfBirth? dob,
    String? email,
    String? firstName,
    String? idNumber,
    String? lastName,
    String? phone,
    String? relationshipExecutive,
    List<String>? relationship,
    String? ssnLast4,
    String? verificationDocument,
  }) {
    return Representative(
      id: id ?? this.id,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      idNumber: idNumber ?? this.idNumber,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      relationshipExecutive:
          relationshipExecutive ?? this.relationshipExecutive,
      relationship: relationship ?? this.relationship,
      ssnLast4: ssnLast4 ?? this.ssnLast4,
      verificationDocument: verificationDocument ?? this.verificationDocument,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'dob': dob?.toMap(),
      'email': email,
      'firstName': firstName,
      'idNumber': idNumber,
      'lastName': lastName,
      'phone': phone,
      'relationshipExecutive': relationshipExecutive,
      'relationship': relationship,
      'ssnLast4': ssnLast4,
      'verificationDocument': verificationDocument,
    };
  }

  factory Representative.fromMap(Map<String, dynamic> map) {
    return Representative(
      id: map['id'] as String,
      address: map['address'] as String,
      dob: map['dob'] != null
          ? DateOfBirth.fromMap(map['dob'] as Map<String, dynamic>)
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      idNumber: map['idNumber'] != null ? map['idNumber'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      relationshipExecutive: map['relationshipExecutive'] != null
          ? map['relationshipExecutive'] as String
          : null,
      relationship: map['relationship'] != null
          ? List<String>.from((map['relationship'] as List<String>))
          : null,
      ssnLast4: map['ssnLast4'] != null ? map['ssnLast4'] as String : null,
      verificationDocument: map['verificationDocument'] != null
          ? map['verificationDocument'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Representative.fromJson(String source) =>
      Representative.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      email as String,
      phone as String,
    ];
  }
}
