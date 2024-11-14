import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Activity extends Equatable {
  final String id;
  final String type;
  final String name;
  final IconData icon;
  final DateTime dateCreated;
  final double amount;
  final String status;

  Activity({
    String? id,
    required this.type,
    required this.name,
    required this.icon,
    DateTime? dateCreated,
    this.amount = 0,
    required this.status,
  })  : id = id ?? const Uuid().v4(),
        dateCreated = dateCreated ?? DateTime.now();

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      icon: json['icon'],
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      amount: json['amount'] as double,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'icon': icon,
      'dateCreated': dateCreated.toIso8601String(),
      'amount': amount,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id];
}
