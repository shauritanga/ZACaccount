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
}
