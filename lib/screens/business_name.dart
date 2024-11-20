import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/industry_question.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class BusinessNameScreen extends ConsumerStatefulWidget {
  const BusinessNameScreen({super.key});

  @override
  ConsumerState<BusinessNameScreen> createState() => _BusinessNameScreenState();
}

class _BusinessNameScreenState extends ConsumerState<BusinessNameScreen> {
  final TextEditingController _businessNameController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled = _businessNameController.text.isNotEmpty &&
        _businessNameController.text.length > 2;

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _businessNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(HugeIcons.strokeRoundedArrowLeft01)),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "What's your business name?",
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
                    controller: _businessNameController,
                    autofocus: true,
                    icon: HugeIcons.strokeRoundedTag01,
                    hintText: "Enter business name",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (p0) => _checkIfAllFieldsFilled(),
                  ),
                ),
                const SizedBox(height: 64),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                        ? () async {
                            ref
                                .read(companyProvider.notifier)
                                .updateBusinessName(
                                    _businessNameController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const SearchPage(),
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
