// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zaccount/models/address.dart';

class BusinessProfile extends Equatable {
  final String? mcc;
  final String? name;
  final String? productDescription;
  final Address? supportAddress;
  final String? supportEmail;
  final String? supportPhone;
  final String? supportURL;
  final String? url;
  const BusinessProfile({
    this.mcc,
    this.name,
    this.productDescription,
    this.supportAddress,
    this.supportEmail,
    this.supportPhone,
    this.supportURL,
    this.url,
  });

  BusinessProfile copyWith({
    String? mcc,
    String? name,
    String? productDescription,
    Address? supportAddress,
    String? supportEmail,
    String? supportPhone,
    String? supportURL,
    String? url,
  }) {
    return BusinessProfile(
      mcc: mcc ?? this.mcc,
      name: name ?? this.name,
      productDescription: productDescription ?? this.productDescription,
      supportAddress: supportAddress ?? this.supportAddress,
      supportEmail: supportEmail ?? this.supportEmail,
      supportPhone: supportPhone ?? this.supportPhone,
      supportURL: supportURL ?? this.supportURL,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mcc': mcc,
      'name': name,
      'productDescription': productDescription,
      'supportAddress': supportAddress?.toMap(),
      'supportEmail': supportEmail,
      'supportPhone': supportPhone,
      'supportURL': supportURL,
      'url': url,
    };
  }

  factory BusinessProfile.fromMap(Map<String, dynamic> map) {
    return BusinessProfile(
      mcc: map['mcc'] != null ? map['mcc'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      productDescription: map['productDescription'] != null
          ? map['productDescription'] as String
          : null,
      supportAddress: map['supportAddress'] != null
          ? Address.fromMap(map['supportAddress'] as Map<String, dynamic>)
          : null,
      supportEmail:
          map['supportEmail'] != null ? map['supportEmail'] as String : null,
      supportPhone:
          map['supportPhone'] != null ? map['supportPhone'] as String : null,
      supportURL:
          map['supportURL'] != null ? map['supportURL'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessProfile.fromJson(String source) =>
      BusinessProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      mcc as String,
      name as String,
      productDescription as String,
      supportAddress as String,
      supportEmail as String,
      supportPhone as String,
      supportURL as String,
      url as String,
    ];
  }
}
