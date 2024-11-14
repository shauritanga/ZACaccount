// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zaccount/models/address.dart';
import 'package:zaccount/models/date_of_birth.dart';

class Individual extends Equatable {
  final String id;
  final Address? address;
  final DateOfBirth? dob;
  final String? email;
  final String? firstName;
  final String? idNumber;
  final String? lastName;
  final String? phone;
  final String? ssnLast4;
  const Individual({
    required this.id,
    this.address,
    this.dob,
    this.email,
    this.firstName,
    this.idNumber,
    this.lastName,
    this.phone,
    this.ssnLast4,
  });

  Individual copyWith({
    String? id,
    Address? address,
    DateOfBirth? dob,
    String? email,
    String? firstName,
    String? idNumber,
    String? lastName,
    String? phone,
    String? ssnLast4,
  }) {
    return Individual(
      id: id ?? this.id,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      idNumber: idNumber ?? this.idNumber,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      ssnLast4: ssnLast4 ?? this.ssnLast4,
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
    };
  }

  factory Individual.fromMap(Map<String, dynamic> map) {
    return Individual(
      id: map['id'] ?? "",
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Individual.fromJson(String source) =>
      Individual.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      address as String,
      email as String,
      ssnLast4 as String,
    ];
  }
}
