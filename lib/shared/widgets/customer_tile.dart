import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerListTile extends ConsumerWidget {
  const CustomerListTile({
    required this.customerName,
    required this.email,
    required this.phone,
    this.onTap,
    super.key,
  });
  final String customerName;
  final String phone;
  final String email;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h, left: 8, right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                CupertinoIcons.person,
                color: Colors.purple,
              ),
              title: Text(customerName),
              subtitle: Row(
                children: [
                  Icon(
                    CupertinoIcons.phone,
                    size: 14.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    phone,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    height: 13,
                    width: 1.5,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                  SizedBox(width: 8.w),
                  Icon(CupertinoIcons.envelope, size: 14.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                      child: Text(
                    email,
                    style: TextStyle(fontSize: 12.sp),
                  ))
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
