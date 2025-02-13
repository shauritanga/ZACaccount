import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/congratulation.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class TinNumberScreen extends ConsumerStatefulWidget {
  const TinNumberScreen({super.key});

  @override
  ConsumerState<TinNumberScreen> createState() => _TinNumberScreenState();
}

class _TinNumberScreenState extends ConsumerState<TinNumberScreen> {
  final TextEditingController _tinController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled =
        _tinController.text.isNotEmpty && _tinController.text.length > 10;

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tinController.dispose();
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
              "Enter your tax identification number (TIN), please",
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
                    controller: _tinController,
                    autofocus: true,
                    icon: Icons.numbers,
                    hintText: "Enter TIN",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [MaskedInputFormatter("###-###-###")],
                    onChanged: (p0) => _checkIfAllFieldsFilled(),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
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
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
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
                                              "Why do I need to enter your full TIN",
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
                                          SizedBox(height: height * 0.02),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              "We will only ask for more information if we are unable to verify your identity with the information you entered",
                                              style: GoogleFonts.roboto(),
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
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
                      "Why do we need this information?",
                      style: GoogleFonts.roboto(fontSize: 12, color: primary),
                    ),
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
                  child: TextButton(
                    onPressed: isButtonEnabled
                        ? () {
                            ref
                                .read(companyProvider.notifier)
                                .updateIndividualSSNLast4(_tinController.text);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const CongratulationScreen(),
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
