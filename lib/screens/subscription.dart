import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:zaccount/utils/constants.dart";

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const Text(
              'ZACcount',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'MEMBERSHIP',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),
            Center(
              child: Image.asset(
                'assets/images/zaclogo.png', // Replace with your logo's URL
                height: 100,
              ),
            ),
            SizedBox(height: 30.h),
            // Features List
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unlimited Invoicing',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Effortlessly create an unlimited number of invoices\nwithout any restrictions.',
                      style: TextStyle(color: Colors.grey),
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
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Multi-Staff Accounts',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Seamlessly add and manage multiple staff accounts\nwithin the app.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            // Restore Purchases
            Center(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.restore),
                label: const Text('Restore Purchases'),
              ),
            ),
            const SizedBox(height: 30),
            // Subscription Options
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: const Text('Free trial /7-days',
                  style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              child:
                  const Text('\$9.99 /Monthly', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.black),
              ),
              onPressed: () {},
              child:
                  const Text('\$99.99 /Yearly', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),
            // Terms of Service and Privacy Policy
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Terms of Service & Privacy Policy',
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
