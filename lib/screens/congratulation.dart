import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/tria.dart';

class CongratulationScreen extends ConsumerStatefulWidget {
  const CongratulationScreen({super.key});

  @override
  ConsumerState<CongratulationScreen> createState() =>
      _CongratulationScreenState();
}

class _CongratulationScreenState extends ConsumerState<CongratulationScreen> {
  Future<void> showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CircleAnimation();
      },
    );

    // Simulate a long-running task (e.g., a network request)
    await ref.read(companyProvider.notifier).addCompanyDetails();

    Navigator.of(context).pop(); // Dismiss the dialog after the task completes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Congratulations, verification process is completed.",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Your verification is currently being processed. You will receive a notification once it is completed or if additional is required",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w800, color: Colors.grey),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    HugeIcons.strokeRoundedSecurityCheck,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Your information is protected",
                    style: GoogleFonts.roboto(color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                onPressed: () async {
                  await showLoadingDialog(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                style: ButtonStyle(
                  foregroundColor:
                      const WidgetStatePropertyAll<Color>(Colors.white),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  minimumSize: const WidgetStatePropertyAll<Size>(
                    Size(double.infinity, 48),
                  ),
                ),
                child: const Text("Save Data and Continue"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
