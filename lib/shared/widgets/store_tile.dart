import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/utils/phone_number_formater.dart';
import 'package:zaccount/shared/widgets/vertical_divider.dart';

class StoreListTile extends ConsumerWidget {
  const StoreListTile({
    required this.storeName,
    required this.district,
    required this.region,
    required this.phoneNumber,
    this.onTap,
    super.key,
  });
  final String storeName;
  final String district;
  final String region;
  final String phoneNumber;
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
                  const Icon(CupertinoIcons.bag),
                  SizedBox(width: 12.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(storeName),
                      Row(
                        children: [
                          Text(district),
                          SizedBox(width: 8.w),
                          const VerticalSeparater(),
                          SizedBox(width: 8.w),
                          Text(region),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Text(formatPhoneNumber(phoneNumber))
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
