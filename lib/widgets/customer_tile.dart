import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/widgets/vertical_divider.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.person,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 12.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customerName),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.phone,
                                size: 12,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                phone,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(width: 8.w),
                          const VerticalSeparater(),
                          SizedBox(width: 8.w),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.envelope,
                                size: 12,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                email,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
