import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/company_address.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    RegExp emailregx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$');
    bool allFieldsFilled = _emailController.text.isNotEmpty &&
        emailregx.hasMatch(_emailController.text);

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
              "What's your company support email?",
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
                    controller: _emailController,
                    autofocus: true,
                    icon: HugeIcons.strokeRoundedTag01,
                    hintText: "Enter email",
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
                                .updateEmail(_emailController.text);
                            ref
                                .read(companyProvider.notifier)
                                .updateBusinessSupportEmail(
                                    _emailController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const CompanyAddressScreen(),
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
