import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:share_plus/share_plus.dart";

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Share"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/zaclogo.png",
                height: 100.h,
              ),
              SizedBox(height: 44.h),
              const Text(
                "Invite your friends to become part of our wonderful accounting ecosystem!",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 34.h),
              ElevatedButton.icon(
                onPressed: () {
                  Share.share("Check this cool app");
                },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  backgroundColor:
                      WidgetStatePropertyAll(Theme.of(context).primaryColor),
                ),
                icon: const Icon(
                  CupertinoIcons.share,
                  color: Colors.white,
                ),
                label: const Text(
                  "Share ZACaccount",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
