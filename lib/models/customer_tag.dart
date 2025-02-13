import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerTag {
  final String id;
  final String name;
  CustomerTag({
    required this.id,
    required this.name,
  });

  CustomerTag copyWith({
    String? id,
    String? name,
  }) {
    return CustomerTag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CustomerTag.fromMap(DocumentSnapshot map) {
    final id = map.id;
    final data = map.data() as Map<String, dynamic>;
    return CustomerTag(
      id: id,
      name: data['name'] ?? '',
    );
  }

  factory CustomerTag.fromDocument(DocumentSnapshot map) {
    return CustomerTag(
      id: map.id,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerTag.fromJson(String source) =>
      CustomerTag.fromMap(json.decode(source));

  @override
  String toString() => 'CustomerTag(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerTag && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
