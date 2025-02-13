import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:zaccount/utils/constants.dart";
import "package:zaccount/shared/widgets/confirm_pay_dialog.dart";
import "package:zaccount/shared/widgets/payment_dialog.dart";
import "package:zaccount/shared/widgets/update_dialog.dart";

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isSubscribed = false;
  String activePlane = "month";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(14.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.close,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Column(
                    children: [
                      Text('ZACcount',
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          SizedBox(width: 190.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'MEMBERSHIP',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 44.h),
            Center(
              child: Image.asset(
                'assets/images/zaclogo.png', // Replace with your logo's URL
                height: 90.h,
              ),
            ),
            SizedBox(height: 54.h),
            // Features List
            Row(
              children: [
                Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.lock_open_fill,
                      color: Colors.white,
                      size: 16.r,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Unlimited Invoicing',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Effortlessly create an unlimited number of invoices\nwithout any restrictions.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  height: 30.h,
                  width: 30.h,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.lock_open_fill,
                      color: Colors.white,
                      size: 16.r,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Multi-Staff Accounts',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Seamlessly add and manage multiple staff accounts\nwithin the app.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.h),
            const Divider(),
            isSubscribed
                ? Column(
                    children: [
                      SizedBox(height: 18.h),
                      const Text(
                        "MEMBERSHIP PURCHASED",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SubscriptionPlan(
                            activePlane: activePlane,
                            plan: "week",
                            fees: 0.00,
                          ),
                          SubscriptionPlan(
                            activePlane: activePlane,
                            plan: "month",
                            fees: 9.99,
                          ),
                          SubscriptionPlan(
                            activePlane: activePlane,
                            plan: "year",
                            fees: 99.99,
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 50),
                          ),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.black),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Manage Membership",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: 24.h),
                      Center(
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.restore),
                          label: const Text('Restore Purchases'),
                        ),
                      ),
                      // Subscription Options
                      TextButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 44),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Free trial /7-days',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      TextButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.red.shade600,
                          ),
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 44),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          '\$9.99 /Monthly',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.surface),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 44),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => PaymentDialog(
                              amount: '\$99.99',
                              title: 'Monthly Premium Access',
                              description:
                                  'Get premium access with monthly subscription',
                              paymentMethod: "M-Pesa",
                              onPay: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => ConfirmPaymentDialog(
                                    phone: "0629-593-331",
                                    description:
                                        "is the phone number above correct for payment? if not, update below",
                                    onPay: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => UpdateDialog(
                                          title: "Update Phone Number",
                                          onPay: () {},
                                          onChancel: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    },
                                    onChancel: () {},
                                  ),
                                );
                              },
                              onChancel: () {},
                            ),
                          );
                        },
                        child: const Text(
                          '\$99.99 /Yearly',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
            // Restore Purchases

            SizedBox(height: 26.h),
            // Terms of Service and Privacy Policy
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service & Privacy Policy',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({
    super.key,
    required this.activePlane,
    required this.plan,
    required this.fees,
  });

  final String activePlane;
  final String plan;
  final double fees;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: activePlane == plan
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            "Active",
            style: TextStyle(
              fontSize: 12,
              color: activePlane == plan ? Colors.white : Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: MediaQuery.sizeOf(context).width / 3 - 40,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                activePlane == plan ? Colors.transparent : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: activePlane == plan
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ),
          child: Column(
            children: [
              const Text(
                "1",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                plan,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$$fees",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
