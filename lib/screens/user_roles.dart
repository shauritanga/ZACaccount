import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/custom_permissions.dart';

class UserRolesScreen extends ConsumerStatefulWidget {
  const UserRolesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRolesScreenState();
}

class _UserRolesScreenState extends ConsumerState<UserRolesScreen> {
  bool _isSwitchOn = false;
  final permissions = [];
  @override
  Widget build(BuildContext context) {
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
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
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
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SingleStickyHeaderDelegate(
              minHeight: 30,
              maxHeight: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Text("Permissions"),
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemCount: CustomPermissions.permissions.length,
            itemBuilder: (context, index) {
              final permission = CustomPermissions.permissions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(permission),
                  trailing: Transform.scale(
                    scale:
                        0.8, // Change this value to scale up or down the switch size
                    child: Switch(
                      value: _isSwitchOn,
                      onChanged: (bool value) {
                        setState(() {
                          _isSwitchOn = value;
                        });
                      },
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isSwitchOn = !_isSwitchOn;
                    });
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                indent: 16.0,
                height: 0,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SingleStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SingleStickyHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // Always rebuild to update content as you scroll.
  }
}
