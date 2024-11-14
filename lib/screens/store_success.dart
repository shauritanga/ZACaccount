import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/screens/store_management.dart';

class StoreSuccessScreen extends StatelessWidget {
  const StoreSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.check_mark_circled_solid,
              size: 70,
              color: Colors.green,
            ),
            const Text("Store Added Successfully"),
            const Text("You have successfully added store name tocompany name"),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Theme.of(context).primaryColor),
                minimumSize: const WidgetStatePropertyAll(
                  Size(double.infinity, 44),
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) {
                  return route is MaterialPageRoute &&
                      route.builder(context) is StoreManagementScreen;
                });
              },
              child: const Text(
                'Finish',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
