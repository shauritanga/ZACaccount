// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String street;
  final String unitNumber;
  final String city;
  final String country;
  final String zipCode;

  const Address({
    required this.street,
    required this.unitNumber,
    required this.city,
    required this.country,
    required this.zipCode,
  });

  factory Address.fromMap(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      unitNumber: json['unitNumber'],
      city: json['city'],
      country: json['country'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'unitNumber': unitNumber,
      'city': city,
      'country': country,
      'zipCode': zipCode,
    };
  }

  @override
  List<Object?> get props => [street, unitNumber];

  Address copyWith({
    String? street,
    String? unitNumber,
    String? city,
    String? country,
    String? zipCode,
  }) {
    return Address(
      street: street ?? this.street,
      unitNumber: unitNumber ?? this.unitNumber,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
    );
  }
}
