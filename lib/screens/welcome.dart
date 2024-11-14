import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/screens/introduction.dart';
import 'package:zaccount/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            Row(
              children: [
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text("Sign Out"))
              ],
            ),
            Text(
              "Welcome to ZACcount Invoices",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Register business takes a few minutes"),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedMailOpen,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Tell us about your business",
                  style: GoogleFonts.roboto(color: primary, fontSize: 18),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 30,
              width: 5,
              color: Colors.grey,
            ),
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedUser,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Tell us about yourself")
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 30,
              width: 5,
              color: Colors.grey,
            ),
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Start invoicing")
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(8),
              color: lightGrey,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const IntroductionScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                    foregroundColor:
                        const WidgetStatePropertyAll<Color>(Colors.white),
                    backgroundColor: WidgetStatePropertyAll<Color>(primary),
                    shape: WidgetStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    minimumSize: const WidgetStatePropertyAll<Size>(
                      Size(double.infinity, 48),
                    )),
                child: const Text("Get started"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
