import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/models/address.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/presentation/providers/distric_provider.dart';
import 'package:zaccount/screens/company_tin_number.dart';
import 'package:zaccount/screens/districts.dart';
import 'package:zaccount/screens/regions.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/widgets/input_form_field.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class CompanyAddressScreen extends ConsumerStatefulWidget {
  const CompanyAddressScreen({super.key});

  @override
  ConsumerState<CompanyAddressScreen> createState() =>
      _CompanyAddressScreenState();
}

class _CompanyAddressScreenState extends ConsumerState<CompanyAddressScreen> {
  String dropdownValue = list.first;
  TextEditingController districtController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  TextEditingController districtSupportController = TextEditingController();
  TextEditingController regionSupportController = TextEditingController();
  TextEditingController unitSupportController = TextEditingController();
  TextEditingController streetSupportController = TextEditingController();

  bool sameAsSupportAddress = true;

  @override
  void dispose() {
    super.dispose();
    districtController.dispose();
    regionController.dispose();
    unitController.dispose();
    streetController.dispose();
    streetSupportController.dispose();
    unitSupportController.dispose();
    regionSupportController.dispose();
    districtSupportController.dispose();
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
              "What is your company address?",
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
                    controller: streetController,
                    icon: CupertinoIcons.map,
                    hintText: "Enter line 1 eg Chole Rd",
                    hintStyle: const TextStyle(color: Colors.grey),
                    onChanged: (text) {
                      setState(() {
                        streetController.text = text;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InputFormField(
                    controller: unitController,
                    icon: CupertinoIcons.map_pin_ellipse,
                    hintText: "Enter unit/apt number",
                    hintStyle: const TextStyle(color: Colors.grey),
                    onChanged: (text) {
                      setState(() {
                        unitController.text = text;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InputFormField(
                    readOnly: true,
                    controller: districtController,
                    icon: CupertinoIcons.building_2_fill,
                    hintText: "Select District",
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    onTap: () async {
                      final result = await showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        builder: (ctx) {
                          return DraggableScrollableSheet(
                            maxChildSize: 1.0,
                            minChildSize: 1.0,
                            initialChildSize: 1.0,
                            snap: true,
                            builder: (context, scrollController) {
                              return DistrictsScreen(
                                  selected: districtController.text);
                            },
                          );
                        },
                      );
                      setState(() {
                        districtController.text = result?.district ?? "";
                        regionController.text = result?.region ?? "";
                      });
                      ref.read(searchQueryProvider.notifier).state = "";
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InputFormField(
                    readOnly: true,
                    controller: regionController,
                    icon: CupertinoIcons.flag,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    hintText: "Select Region",
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        builder: (ctx) {
                          return DraggableScrollableSheet(
                            maxChildSize: 1.0,
                            minChildSize: 1.0,
                            initialChildSize: 1.0,
                            snap: true,
                            builder: (context, scrollController) {
                              return RegionsScreen(
                                  selected: regionController.text);
                            },
                          );
                        },
                      );
                      ref.read(searchQueryProvider.notifier).state = "";
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          // color: lightGrey,
                          borderRadius: BorderRadius.circular(3)),
                      child: Transform.scale(
                        scale: 0.6,
                        child: Switch(
                          value: sameAsSupportAddress,
                          onChanged: (value) {
                            setState(() {
                              sameAsSupportAddress = !sameAsSupportAddress;
                            });
                          },
                          activeColor: Colors.white,
                          trackColor: WidgetStatePropertyAll(primary),
                        ),
                      ),
                    ),
                    const Text("Same as customer support address"),
                  ],
                ),
                sameAsSupportAddress
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: Text(
                              "Customer Spport Address",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InputFormField(
                              controller: streetSupportController,
                              icon: CupertinoIcons.map,
                              hintText: "Enter line 1 eg Chole Rd",
                              hintStyle: const TextStyle(color: Colors.grey),
                              onChanged: (text) {
                                setState(() {
                                  streetSupportController.text = text;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InputFormField(
                              controller: unitSupportController,
                              icon: CupertinoIcons.map_pin_ellipse,
                              hintText: "Enter unit/apt number",
                              hintStyle: const TextStyle(color: Colors.grey),
                              onChanged: (text) {
                                setState(() {
                                  unitSupportController.text = text;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InputFormField(
                              readOnly: true,
                              controller: districtSupportController,
                              icon: CupertinoIcons.building_2_fill,
                              hintText: "Select District",
                              suffixIcon: const Icon(Icons.keyboard_arrow_down),
                              onTap: () async {
                                final result = await showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  useSafeArea: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  builder: (ctx) {
                                    return DraggableScrollableSheet(
                                      maxChildSize: 1.0,
                                      minChildSize: 1.0,
                                      initialChildSize: 1.0,
                                      snap: true,
                                      builder: (context, scrollController) {
                                        return DistrictsScreen(
                                            selected:
                                                districtSupportController.text);
                                      },
                                    );
                                  },
                                );
                                setState(() {
                                  districtSupportController.text =
                                      result?.district ?? "";
                                  regionSupportController.text =
                                      result?.region ?? "";
                                });
                                ref.read(searchQueryProvider.notifier).state =
                                    "";
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InputFormField(
                              readOnly: true,
                              controller: regionSupportController,
                              icon: CupertinoIcons.flag,
                              suffixIcon: const Icon(Icons.keyboard_arrow_down),
                              hintText: "Select Region",
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  useSafeArea: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  builder: (ctx) {
                                    return DraggableScrollableSheet(
                                      maxChildSize: 1.0,
                                      minChildSize: 1.0,
                                      initialChildSize: 1.0,
                                      snap: true,
                                      builder: (context, scrollController) {
                                        return RegionsScreen(
                                            selected:
                                                regionSupportController.text);
                                      },
                                    );
                                  },
                                );
                                ref.read(searchQueryProvider.notifier).state =
                                    "";
                              },
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  color: lightGrey,
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(companyProvider.notifier)
                          .updateCompanyProfileAddress(
                            Address(
                              street: streetController.text,
                              unitNumber: unitController.text,
                              city: districtController.text,
                              country: regionController.text,
                              zipCode: "00000",
                            ),
                          );
                      sameAsSupportAddress
                          ? ref
                              .read(companyProvider.notifier)
                              .updateBusinessSupportAddress(
                                Address(
                                  street: streetController.text,
                                  unitNumber: unitController.text,
                                  city: districtController.text,
                                  country: regionController.text,
                                  zipCode: "00000",
                                ),
                              )
                          : ref
                              .read(companyProvider.notifier)
                              .updateBusinessSupportAddress(
                                Address(
                                  street: streetSupportController.text,
                                  unitNumber: unitSupportController.text,
                                  city: districtSupportController.text,
                                  country: regionSupportController.text,
                                  zipCode: "00000",
                                ),
                              );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const CompanyTinNumberScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            const WidgetStatePropertyAll<Color>(Colors.white),
                        backgroundColor: WidgetStatePropertyAll<Color>(primary),
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
