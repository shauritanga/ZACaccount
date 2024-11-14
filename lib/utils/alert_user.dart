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
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ))
              ],
            ),
            Image.asset(
              "assets/images/email.gif",
              height: 150.h,
            ),
            SizedBox(height: 44.h),
            const Text(
              "Verification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            const Text(
              "We have sent verification email to your email address. Please veriy to continue",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  );
}
