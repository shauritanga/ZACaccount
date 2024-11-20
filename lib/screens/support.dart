import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zaccount/utils/constants.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future _textMe(String phone) async {
    final smsUri = Uri(scheme: 'sms', path: phone);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $smsUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 242, 242, 242),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary.withOpacity(0.7),
                  primary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.7],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(HugeIcons.strokeRoundedArrowLeft01),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "Hello, Athanas",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Transform.rotate(
                        angle: -pi * 0.25,
                        child: const Icon(
                          CupertinoIcons.hand_raised_fill,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "How can we help?",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0.09),
                          blurRadius: 0.05,
                          spreadRadius: 5,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Start a converstion",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 87.w,
                                  color: Colors.yellow,
                                ),
                                Container(
                                  width: 29,
                                  height: 29,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        "https://plus.unsplash.com/premium_photo-1689551670902-19b441a6afde?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzN8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  child: Container(
                                    width: 29,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1612636322033-f48f76c34bab?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzQ2fHxwcm9mZXNzaW9uYWx8ZW58MHx8MHx8fDA%3D"),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 40,
                                  child: Container(
                                    width: 29,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          "https://plus.unsplash.com/premium_photo-1689977927774-401b12d137d6?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(width: 10.w),
                            Column(
                              children: [
                                Text(
                                  "We typically reply in",
                                  style: GoogleFonts.roboto(color: Colors.grey),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    const Icon(
                                      HugeIcons.strokeRoundedTime04,
                                      size: 16,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "less than 2 hours",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              _textMe("0629593331");
                            },
                            icon: const Icon(
                              CupertinoIcons.paperplane,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(primary),
                            ),
                            label: Text(
                              "Send us a message",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const Divider(),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "FAQs",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ExpansionTile(
                    clipBehavior: ExpansionTileTheme.of(context).clipBehavior,
                    tilePadding: EdgeInsets.zero,
                    enableFeedback: false,
                    expansionAnimationStyle: AnimationStyle(
                      duration: const Duration(milliseconds: 300),
                    ),
                    shape: const RoundedRectangleBorder(),
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "How do I reset my password?",
                      style: GoogleFonts.roboto(color: primary, fontSize: 14),
                    ),
                    children: [
                      Text(
                        "To reset your password, go to the settings page and select 'Reset Password'",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: ExpansionTile(
                      enableFeedback: false,
                      expansionAnimationStyle: AnimationStyle(
                        duration: const Duration(milliseconds: 300),
                      ),
                      tilePadding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(),
                      expandedAlignment: Alignment.centerLeft,
                      title: Text(
                        "What payment methods do you accept?",
                        style: GoogleFonts.roboto(color: primary, fontSize: 14),
                      ),
                      children: [
                        Text(
                          "We accept Visa, MasterCard, American Express and PayPal",
                          style: GoogleFonts.roboto(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ExpansionTile(
                    enableFeedback: false,
                    expansionAnimationStyle: AnimationStyle(
                      duration: const Duration(milliseconds: 300),
                    ),
                    tilePadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(),
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "Can I cancel my subscription?",
                      style: GoogleFonts.roboto(color: primary, fontSize: 14),
                    ),
                    children: [
                      Text(
                        "Yes, you can cancel your subscription anytime by going to the subscription settings.",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
