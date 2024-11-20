import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/welcome_two.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class CompanyTinNumberScreen extends ConsumerStatefulWidget {
  const CompanyTinNumberScreen({super.key});

  @override
  ConsumerState<CompanyTinNumberScreen> createState() =>
      _CompanyTinNumberScreenState();
}

class _CompanyTinNumberScreenState
    extends ConsumerState<CompanyTinNumberScreen> {
  final TextEditingController _ninController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled =
        _ninController.text.isNotEmpty && _ninController.text.length > 10;

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ninController.dispose();
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "What's your company Tax Identification Number?",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w800, fontSize: 20.sp),
            ),
          ),
          SizedBox(height: 16.h),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InputFormField(
                    controller: _ninController,
                    autofocus: true,
                    icon: Icons.numbers,
                    hintText: "Enter TIN",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [MaskedInputFormatter("###-###-###")],
                    onChanged: (text) => _checkIfAllFieldsFilled(),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        showDragHandle: true,
                        useSafeArea: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        builder: (BuildContext context) {
                          double height = MediaQuery.of(context).size.height;
                          return DraggableScrollableSheet(
                            initialChildSize: 1.0, //set this as you want
                            maxChildSize: 1.0, //set this as you want
                            minChildSize: 1.0, //set this as you want
                            expand: true,
                            builder: (context, scrollController) {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: CustomScrollView(
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          SizedBox(height: height * 0.02),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              "Why do we need your EID/TIN",
                                              style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              "ZACcount is required by law to collect this information in order to verify your identity.",
                                              style: GoogleFonts.roboto(),
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              "We will only ask for more information if we are unable to verify your identity with the information you entered",
                                              style: GoogleFonts.roboto(),
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            child: Text(
                                              "Your information is encrypted and securely transmitted using SSL",
                                              style: GoogleFonts.roboto(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ); //whatever you're returning, does not have to be a Container
                            },
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.grey.shade300),
                    ),
                    child: Text(
                      "Why do we need your EID/TIN?",
                      style: GoogleFonts.roboto(fontSize: 12, color: primary),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      const Icon(
                        HugeIcons.strokeRoundedSecurityCheck,
                        color: Colors.green,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Your information is protected",
                        style: GoogleFonts.roboto(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
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
                        ? () {
                            ref
                                .read(companyProvider.notifier)
                                .updateCompanyProfileTaxId(_ninController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const WelcomeScreenTwo(),
                              ),
                            );
                          }
                        : null,
                    child: const Text(
                      'Verify Company',
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
