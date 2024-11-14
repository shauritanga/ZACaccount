import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/phone_number.dart';

import 'package:zaccount/widgets/input_form_field.dart';

class CompanyWebsiteScreen extends ConsumerStatefulWidget {
  const CompanyWebsiteScreen({super.key});

  @override
  ConsumerState<CompanyWebsiteScreen> createState() =>
      _CompanyWebsiteScreenState();
}

class _CompanyWebsiteScreenState extends ConsumerState<CompanyWebsiteScreen> {
  final TextEditingController _websiteController = TextEditingController();
  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled = _websiteController.text.isNotEmpty &&
        _websiteController.text.length > 3;

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _websiteController.dispose();
  }

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
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "What's your company website?",
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
                  child: InputFormField(
                    controller: _websiteController,
                    autofocus: true,
                    icon: HugeIcons.strokeRoundedTag01,
                    hintText: "Enter company website(optional)",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (text) => _checkIfAllFieldsFilled(),
                  ),
                ),
                const SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        isButtonEnabled
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                      ),
                      minimumSize: const WidgetStatePropertyAll(
                        Size(double.infinity, 44),
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    onPressed: isButtonEnabled
                        ? () {
                            ref
                                .read(companyProvider.notifier)
                                .updateBusinessSupportURL(
                                    _websiteController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const PhoneScreen(),
                              ),
                            );
                          }
                        : null,
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
