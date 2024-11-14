import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/screens/business_type.dart';
import 'package:zaccount/utils/constants.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(HugeIcons.strokeRoundedArrowLeft01),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tell us about your business",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Image.network(
              "https://img.freepik.com/premium-vector/man-suit-sits-desk-with-laptop-star-him_704913-30547.jpg?uid=R164844883&ga=GA1.1.2120699558.1727088395&semt=ais_hybrid",
              height: 450,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BusinessTypeScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(primary),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    minimumSize: const WidgetStatePropertyAll<Size>(
                        Size(double.infinity, 44))),
                child: Text(
                  "Continue",
                  style: GoogleFonts.roboto(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
