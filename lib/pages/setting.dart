import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/user_data_provider.dart';
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
import 'package:zaccount/widgets/custom_button.dart';
import 'package:zaccount/widgets/menu_list_item.dart';

class SettingsPage extends ConsumerWidget {
  SettingsPage({super.key});

  late double _deviceWidth, _deviceHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final user = ref.watch(userProvider);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
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
                _userInfoWidget(context, currentUser, user),
                SizedBox(
                  height: 20.h,
                ),
                _menuList(context),
                const SizedBox(
                  height: 36,
                ),
                _signOutWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfoWidget(context, User? currentUser, LocalUser user) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03, vertical: _deviceWidth * 0.02),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: _deviceHeight * 0.05,
            height: _deviceHeight * 0.05,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(_deviceHeight * 0.05),
            ),
            child: const Center(
              child: Icon(
                HugeIcons.strokeRoundedUser,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: _deviceWidth * 0.04,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.user?.firstName} ${user.user?.lastName}",
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
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
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
            indent: _deviceWidth * 0.08,
            thickness: 0.5,
            endIndent: 0,
          ),
          const MenuListItem(
            title: "Delte Account",
            color: Color(0xffFE0000),
          ),
        ],
      ),
    );
  }

  Widget _signOutWidget() {
    return CustomButton(
      deviceWidth: _deviceWidth,
      deviceHeight: _deviceHeight,
      title: "Sign Out",
    );
  }
}
