// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class StaffDetails extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final String? department;
  final String? storeId;
  final String? storeName;
  final String? storeLocation;
  final DateTime createdAt;
  final DateTime updatedAt;
  StaffDetails({
    String? id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.department,
    this.storeId,
    this.storeName,
    this.storeLocation,
    required this.createdAt,
    required this.updatedAt,
  }) : id = id ?? const Uuid().v4();

  StaffDetails copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? department,
    String? storeId,
    String? storeName,
    String? storeLocation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StaffDetails(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      department: department ?? this.department,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeLocation: storeLocation ?? this.storeLocation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'department': department,
      'storeId': storeId,
      'storeName': storeName,
      'storeLocation': storeLocation,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory StaffDetails.fromDocument(DocumentSnapshot map) {
    return StaffDetails(
      id: map.id,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      department:
          map['department'] != null ? map['department'] as String : null,
      storeId: map['storeId'] != null ? map['storeId'] as String : null,
      storeName: map['storeName'] != null ? map['storeName'] as String : null,
      storeLocation:
          map['storeLocation'] != null ? map['storeLocation'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  factory StaffDetails.fromMap(Map<String, dynamic> map) {
    return StaffDetails(
      id: map['id'] as String,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      department:
          map['department'] != null ? map['department'] as String : null,
      storeId: map['storeId'] != null ? map['storeId'] as String : null,
      storeName: map['storeName'] != null ? map['storeName'] as String : null,
      storeLocation:
          map['storeLocation'] != null ? map['storeLocation'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffDetails.fromJson(String source) =>
      StaffDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      firstName as String,
      lastName as String,
      email as String,
      phone as String,
      role as String,
      department as String,
      storeId as String,
      storeName as String,
      storeLocation as String,
      createdAt,
      updatedAt,
    ];
  }
}
