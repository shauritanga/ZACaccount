// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/address.dart';

class Store {
  final String id;
  final String name;
  final String registrationNumber;
  final String taxRegistrationNumber;
  final Address address;
  final String managerName;
  final String email;
  final String phone;
  final String mobileNumber;
  final String faxNumber;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  Store({
    String? id,
    this.name = "",
    this.registrationNumber = "",
    this.taxRegistrationNumber = "",
    required this.address,
    this.managerName = "",
    this.email = "",
    this.phone = "",
    this.mobileNumber = "",
    this.faxNumber = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Store.fromDocument(DocumentSnapshot json) {
    return Store(
      id: json.id,
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      taxRegistrationNumber: json['taxRegistrationNumber'],
      address: Address.fromMap(json['address']),
      managerName: json['managerName'],
      email: json['email'],
      phone: json['phone'],
      mobileNumber: json['mobileNumber'],
      faxNumber: json['faxNumber'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      taxRegistrationNumber: json['taxRegistrationNumber'],
      address: Address.fromMap(json['address']),
      managerName: json['managerName'],
      email: json['email'],
      phone: json['phone'],
      mobileNumber: json['mobileNumber'],
      faxNumber: json['faxNumber'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registrationNumber': registrationNumber,
      'taxRegistrationNumber': taxRegistrationNumber,
      'address': address.toMap(),
      'managerName': managerName,
      'email': email,
      'phone': phone,
      'mobileNumber': mobileNumber,
      'faxNumber': faxNumber,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Store copyWith({
    String? id,
    String? name,
    String? registrationNumber,
    String? taxRegistrationNumber,
    Address? address,
    String? managerName,
    String? email,
    String? phone,
    String? mobileNumber,
    String? faxNumber,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      taxRegistrationNumber:
          taxRegistrationNumber ?? this.taxRegistrationNumber,
      address: address ?? this.address,
      managerName: managerName ?? this.managerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      faxNumber: faxNumber ?? this.faxNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
