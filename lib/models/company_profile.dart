// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zaccount/models/address.dart';

class CompanyProfile extends Equatable {
  final String name;
  final String phone;
  final String taxId;
  final Address address;
  const CompanyProfile({
    required this.name,
    required this.phone,
    required this.taxId,
    required this.address,
  });

  CompanyProfile copyWith({
    String? name,
    String? phone,
    String? taxId,
    Address? address,
  }) {
    return CompanyProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      taxId: taxId ?? this.taxId,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'taxId': taxId,
      'address': address.toMap(),
    };
  }

  factory CompanyProfile.fromMap(Map<String, dynamic> map) {
    return CompanyProfile(
      name: map['name'] as String,
      phone: map['phone'] as String,
      taxId: map['taxId'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyProfile.fromJson(String source) =>
      CompanyProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, phone, taxId, address];
}
