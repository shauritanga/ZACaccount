import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zaccount/models/custom_permissions.dart';

class Role {
  String? id;
  String roleName;
  CustomPermissions permissions;

  Role({this.id, required this.roleName, required this.permissions});

  // Convert Role to Map for easier storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roleName': roleName,
      'permissions': permissions.toMap(),
    };
  }

  // Create Role from Map
  factory Role.fromMap(Map<String, dynamic> map, String id) {
    return Role(
      id: id,
      roleName: map['roleName'],
      permissions: CustomPermissions()
        ..updateFromMap(Map<String, bool>.from(map['permissions'])),
    );
  }

  // Create Role from Map
  factory Role.fromDocument(DocumentSnapshot map) {
    return Role(
      id: map.id,
      roleName: map['roleName'],
      permissions: CustomPermissions()
        ..updateFromMap(Map<String, bool>.from(map['permissions'])),
    );
  }
}
