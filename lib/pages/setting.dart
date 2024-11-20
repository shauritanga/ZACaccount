import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/models/company.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/about.dart';
import 'package:zaccount/screens/access_management.dart';
import 'package:zaccount/screens/company_details.dart';
import 'package:zaccount/screens/notification.dart';
import 'package:zaccount/screens/profile.dart';
import 'package:zaccount/screens/share.dart';
import 'package:zaccount/screens/staff_management.dart';
import 'package:zaccount/screens/store_management.dart';
import 'package:zaccount/screens/subscription.dart';
import 'package:zaccount/screens/support.dart';
import 'package:zaccount/shared/services/auth_services.dart';
import 'package:zaccount/shared/widgets/custom_button.dart';
import 'package:zaccount/shared/widgets/menu_list_item.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final company = ref.watch(companyProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Settings",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                _userInfoWidget(context, currentUser, company),
                SizedBox(
                  height: 20.h,
                ),
                _menuList(context),
                const SizedBox(
                  height: 36,
                ),
                _signOutWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfoWidget(context, User? currentUser, Company company) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 56.h,
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Center(
              child: Icon(
                HugeIcons.strokeRoundedUser,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 8.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${company.individual?.firstName} ${company.individual?.lastName}",
                style: GoogleFonts.roboto(fontSize: 18),
              ),
              Text(
                "${currentUser?.email}",
                style: GoogleFonts.roboto(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _menuList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          MenuListItem(
            leading: HugeIcons.strokeRoundedUser,
            title: "Profile",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const ProfileScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: HugeIcons.strokeRoundedCity01,
            title: "Company Details",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const CompanyDetailsScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.rectangle_stack_person_crop,
            title: "Staff management",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const StaffManagementScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.cube_box,
            title: "Store management",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const StoreManagementScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: HugeIcons.strokeRoundedTools,
            title: "Access management",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AccessManagementScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.bell_fill,
            title: "Notification",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const NotificationScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.money_dollar_circle,
            title: "Subscription",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const SubscriptionScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.hand_raised_fill,
            title: "Support",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const SupportScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.square_arrow_up_fill,
            title: "Refer a friend",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const ShareScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            leading: CupertinoIcons.question,
            title: "About",
            trailing: HugeIcons.strokeRoundedArrowRight01,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => AboutScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 8,
            indent: 16.h,
            thickness: 0.5,
            endIndent: 0,
          ),
          MenuListItem(
            title: "Delte Account",
            color: const Color(0xffFE0000),
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are you sure you want to delete this account?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(),
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 24),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter email",
                                      ),
                                    ),
                                    TextField(
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter password",
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (_emailController.text.isEmpty ||
                                            _passwordController.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Fill all fileds"),
                                            ),
                                          );
                                        }

                                        await authService.deleteAccount(
                                            _emailController.text,
                                            _passwordController.text);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text("Ok"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _signOutWidget(BuildContext context) {
    return CustomButton(
      onTap: () => FirebaseAuth.instance.signOut(),
      deviceWidth: MediaQuery.sizeOf(context).width,
      deviceHeight: MediaQuery.sizeOf(context).height,
      title: "Sign Out",
    );
  }
}
