import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/models/custom_permissions.dart';
import 'package:zaccount/presentation/providers/role_provider.dart';
import 'package:zaccount/screens/role_details.dart';
import 'package:zaccount/screens/user_roles.dart';
import 'package:zaccount/shared/widgets/custom_search_box.dart';

class AccessManagementScreen extends ConsumerStatefulWidget {
  const AccessManagementScreen({this.isClickabe = false, super.key});
  final bool isClickabe;

  @override
  ConsumerState<AccessManagementScreen> createState() =>
      _AccessManagementScreenState();
}

class _AccessManagementScreenState
    extends ConsumerState<AccessManagementScreen> {
  final permissions = CustomPermissions();
  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(roleStremProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            child: Center(
                              child: Container(
                                width: 25.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 2, 33, 80)
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                    size: 18.r,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Access Management",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (ctx) => UserRolesScreen(
                                  permissions: permissions,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 50.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Container(
                                width: 25.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 2, 33, 80)
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomSearchBox(
                      searchTitle: "Search...",
                      deviceWidth: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),
          asyncValue.when(
            data: (data) {
              if (data.isEmpty) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "No any data found",
                    style: TextStyle(),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final role = data[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RoleDetailsScreen(
                              role: role,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          role.roleName,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const CupertinoActivityIndicator(),
          )
        ],
      ),
    );
  }
}
