// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:zaccount/models/address.dart';
import 'package:zaccount/models/date_of_birth.dart';

class Owner {
  String id;
  Address? address;
  DateOfBirth? dob;
  String? email;
  String? firstName;
  String? idNumber;
  String? lastName;
  String? phone;
  String? ssnLast4;
  String? verificationDocument;
  Owner({
    required this.id,
    this.address,
    this.dob,
    this.email,
    this.firstName,
    this.idNumber,
    this.lastName,
    this.phone,
    this.ssnLast4,
    this.verificationDocument,
  });

  Owner copyWith({
    String? id,
    Address? address,
    DateOfBirth? dob,
    String? email,
    String? firstName,
    String? idNumber,
    String? lastName,
    String? phone,
    String? ssnLast4,
    String? verificationDocument,
  }) {
    return Owner(
      id: id ?? this.id,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      idNumber: idNumber ?? this.idNumber,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      ssnLast4: ssnLast4 ?? this.ssnLast4,
      verificationDocument: verificationDocument ?? this.verificationDocument,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address?.toMap(),
      'dob': dob?.toMap(),
      'email': email,
      'firstName': firstName,
      'idNumber': idNumber,
      'lastName': lastName,
      'phone': phone,
      'ssnLast4': ssnLast4,
      'verificationDocument': verificationDocument,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'] as String,
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      dob: map['dob'] != null
          ? DateOfBirth.fromMap(map['dob'] as Map<String, dynamic>)
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      idNumber: map['idNumber'] != null ? map['idNumber'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      ssnLast4: map['ssnLast4'] != null ? map['ssnLast4'] as String : null,
      verificationDocument: map['verificationDocument'] != null
          ? map['verificationDocument'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Owner.fromJson(String source) =>
      Owner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Owner(id: $id, address: $address, dob: $dob, email: $email, firstName: $firstName, idNumber: $idNumber, lastName: $lastName, phone: $phone, ssnLast4: $ssnLast4, verificationDocument: $verificationDocument)';
  }

  @override
  bool operator ==(covariant Owner other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.address == address &&
        other.dob == dob &&
        other.email == email &&
        other.firstName == firstName &&
        other.idNumber == idNumber &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.ssnLast4 == ssnLast4 &&
        other.verificationDocument == verificationDocument;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address.hashCode ^
        dob.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        idNumber.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        ssnLast4.hashCode ^
        verificationDocument.hashCode;
  }
}
