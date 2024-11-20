import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:url_launcher/url_launcher.dart";
import "package:zaccount/utils/constants.dart";

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  late double _deviceHeight, _deviceWidth;

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'supports@zaccount.com', // Recipient email
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/images/zaclogo.png",
              width: 150.w,
            ),
            SizedBox(height: 18.h),
            Text(
              "ZACcount",
              style: GoogleFonts.roboto(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Version 1.0.0",
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16.h),
            Text(
              "Thank you for choosing ZACcount! Streamline your financial tasks and make business management easier.",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
            Text(
              "Developed by: ZACcount Inc",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Contact: ",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await sendEmail();
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  child: Text(
                    "supports@zaccount.com",
                    style: GoogleFonts.roboto(
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 229, 229, 229),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  child: Text(
                    "Privacy Policy",
                    style: GoogleFonts.roboto(
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 229, 229, 229),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  child: Text(
                    "Terms of services",
                    style: GoogleFonts.roboto(
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
            const Align(
              heightFactor: 4,
              alignment: Alignment.bottomCenter,
              child: Text("\u00A9 2024 ZACcount. All rights reserved."),
            )
          ],
        ),
      ),
    );
  }

  Container _decorationContainer() {
    return Container(
      height: _deviceWidth * 0.15,
      width: _deviceWidth * 0.15,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 229, 229),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
