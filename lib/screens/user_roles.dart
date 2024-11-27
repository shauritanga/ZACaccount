import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/models/custom_permissions.dart';
import 'package:zaccount/models/role.dart';

class UserRolesScreen extends ConsumerStatefulWidget {
  const UserRolesScreen({required this.permissions, super.key});
  final CustomPermissions permissions;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRolesScreenState();
}

class _UserRolesScreenState extends ConsumerState<UserRolesScreen> {
  final TextEditingController _roleNameController = TextEditingController();
  final CustomPermissions _permissions = CustomPermissions();

  void _saveRole() {
    final roleName = _roleNameController.text.trim();

    if (roleName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Role name cannot be empty')),
      );
      return;
    }

    // Create Role object
    final newRole = Role(roleName: roleName, permissions: _permissions);

    // Save to Firestore or any database
    // Example for Firestore:
    FirebaseFirestore.instance
        .collection('roles')
        .add(newRole.toMap())
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Role saved successfully')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save role: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final permissionsMap = _permissions.toMap();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.clear_circled_solid,
          ),
        ),
        title: const Text("Create User Roles"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _roleNameController,
                  decoration: InputDecoration(
                    hintText: "Enter role title",
                    hintStyle: const TextStyle(color: Colors.grey),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text("Permissions"),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: permissionsMap.keys.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: permissionsMap[entry]!,
                    onChanged: (value) {
                      setState(() {
                        _permissions.updateFromMap({entry: value});
                      });
                    },
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                minimumSize: Size(double.infinity, 56.h),
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              _saveRole();
            },
            child: const Text(
              "Add Role",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
