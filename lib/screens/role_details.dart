import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/custom_permissions.dart';
import 'package:zaccount/models/role.dart';

class RoleDetailsScreen extends ConsumerStatefulWidget {
  const RoleDetailsScreen({required this.role, super.key});
  final Role role;

  @override
  ConsumerState<RoleDetailsScreen> createState() => _RoleDetailsScreenState();
}

class _RoleDetailsScreenState extends ConsumerState<RoleDetailsScreen> {
  late final CustomPermissions _permissions;

  void _updateRole(String roleId) {
    print(_permissions.canEditSalesData);
    FirebaseFirestore.instance
        .collection('roles')
        .doc(roleId)
        .set({'permissions': _permissions}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Role updated successfully')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save role: $error')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _permissions = widget.role.permissions;
  }

  @override
  Widget build(BuildContext context) {
    final permissionsMap = widget.role.permissions.toMap();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.clear),
        ),
        title: Text(widget.role.roleName),
        actions: [
          TextButton(
              onPressed: () {
                _updateRole(widget.role.id!);
                Navigator.pop(context);
              },
              child: const Text("Update")),
        ],
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
    );
  }
}
