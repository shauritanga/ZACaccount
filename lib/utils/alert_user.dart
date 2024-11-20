import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> alertUserVerification(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        height: MediaQuery.sizeOf(context).height * 0.45,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ))
              ],
            ),
            Image.asset(
              "assets/images/email.gif",
              height: 150.h,
            ),
            SizedBox(height: 32.h),
            Text(
              "Verification",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "We have sent verification email to your email address. Please veriy to continue",
              style: TextStyle(
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  );
}
