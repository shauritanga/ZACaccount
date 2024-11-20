import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstLandingScreen extends StatelessWidget {
  const FirstLandingScreen({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        CachedNetworkImage(
            imageUrl:
                "https://img.freepik.com/free-vector/flat-people-business-training-illustration_23-2148922530.jpg?semt=ais_hybrid"),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Effortless Financial Management",
            style: GoogleFonts.roboto(
              fontSize: 40.sp,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Welcome to ZACcount, your go-to solution for streamlined financial management",
            style: GoogleFonts.roboto(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
            minimumSize: const WidgetStatePropertyAll<Size>(Size(200, 44)),
          ),
          child: const Text(
            "next",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
