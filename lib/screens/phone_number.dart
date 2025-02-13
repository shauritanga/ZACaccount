import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/email.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});

  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled =
        _phoneController.text.isNotEmpty && _phoneController.text.length > 11;

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  dispose() {
    super.dispose();
    _phoneController.dispose();
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
              "What is your company phone number?",
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
                    controller: _phoneController,
                    autofocus: true,
                    icon: HugeIcons.strokeRoundedCall02,
                    hintText: "Enter phone number",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      MaskedInputFormatter("####-###-###"),
                    ],
                    onChanged: (text) => _checkIfAllFieldsFilled(),
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
                                .updateCompanyProfilePhone(
                                    _phoneController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const EmailScreen(),
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
