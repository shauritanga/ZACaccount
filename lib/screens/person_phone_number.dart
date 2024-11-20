import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/tin_number.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class PersonPhoneScreen extends ConsumerStatefulWidget {
  const PersonPhoneScreen({super.key});

  @override
  ConsumerState<PersonPhoneScreen> createState() => _PersonPhoneScreenState();
}

class _PersonPhoneScreenState extends ConsumerState<PersonPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    RegExp tanzaniaPhoneRegex = RegExp(r'^(06|07|08)\d{8}$');
    final phone = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    bool allFieldsFilled = _phoneController.text.isNotEmpty &&
        _phoneController.text.length > 11 &&
        tanzaniaPhoneRegex.hasMatch(phone);

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  void dispose() {
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
              "What is your phone number?",
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
                    hintText: "0xxxxxxxxx",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      MaskedInputFormatter("####-###-###"),
                    ],
                    onChanged: (p0) => _checkIfAllFieldsFilled(),
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
                  color: lightGrey,
                  child: TextButton(
                    onPressed: isButtonEnabled
                        ? () {
                            final phone = _phoneController.text
                                .replaceAll(RegExp(r'[^0-9]'), '');
                            ref
                                .read(companyProvider.notifier)
                                .updateIndividualPhone(phone);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const TinNumberScreen(),
                              ),
                            );
                          }
                        : null,
                    style: ButtonStyle(
                        foregroundColor:
                            const WidgetStatePropertyAll<Color>(Colors.white),
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            isButtonEnabled
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
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
