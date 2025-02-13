import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/screens/person_names.dart';

class WelcomeScreenTwo extends StatelessWidget {
  const WelcomeScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Theme.of(context).primaryColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedMailOpen,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Tell us about your business",
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
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedUser,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Tell us about yourself",
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).primaryColor, fontSize: 18),
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
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const PersonalNameScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                    foregroundColor:
                        const WidgetStatePropertyAll<Color>(Colors.white),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).primaryColor),
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
