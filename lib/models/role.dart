// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:zaccount/models/custom_permissions.dart';

class Role {
  final String id;
  final String name;
  List<CustomPermissions>? permissions;
  Role({
    required this.id,
    required this.name,
    this.permissions,
  });

  Role copyWith({
    String? id,
    String? name,
    List<CustomPermissions>? permissions,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'permissions': permissions?.map((x) => x.toMap()).toList(),
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] as String,
      name: map['name'] as String,
      permissions: map['permissions'] != null
          ? List<CustomPermissions>.from(
              (map['permissions'] as List<int>).map<CustomPermissions?>(
                (x) => CustomPermissions.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Role(id: $id, name: $name, permissions: $permissions)';

  @override
  bool operator ==(covariant Role other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.permissions, permissions);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ permissions.hashCode;
}
