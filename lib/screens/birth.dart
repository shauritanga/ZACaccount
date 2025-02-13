import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/models/date_of_birth.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/person_phone_number.dart';
import 'package:zaccount/shared/widgets/dob_input.dart';

class BirthScreen extends ConsumerStatefulWidget {
  const BirthScreen({super.key});

  @override
  ConsumerState<BirthScreen> createState() => _BirthScreenState();
}

class _BirthScreenState extends ConsumerState<BirthScreen> {
  String dob = "";
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
              "What's your date of birth?",
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BirthDateInput(
                    onDateChanged: (String date) {
                      setState(() {
                        dob = date;
                      });
                    },
                  ),
                ),
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
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print(dob);
                      }

                      int day = int.parse(dob.split("/")[0]);
                      int month = int.parse(dob.split("/")[1]);
                      int year = int.parse(dob.split("/")[2]);

                      ref.read(companyProvider.notifier).updateIndividualDOB(
                            DateOfBirth(day: day, month: month, year: year),
                          );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const PersonPhoneScreen(),
                        ),
                      );
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
                        )),
                    child: const Text("Continue"),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
