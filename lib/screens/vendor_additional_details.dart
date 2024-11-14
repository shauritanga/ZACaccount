import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/models/vendor.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';
import 'package:zaccount/utils/constants.dart';

class VendorAdditionalDetailsForm extends ConsumerStatefulWidget {
  const VendorAdditionalDetailsForm({this.vendor, super.key});

  final Vendor? vendor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendorAdditionalDetailsFormState();
}

class _VendorAdditionalDetailsFormState
    extends ConsumerState<VendorAdditionalDetailsForm> {
  String openingBalance = "";
  String notes = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vendorNotifier = ref.watch(vendorProviderNotifier.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Additional Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(190, 233, 233, 233),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "TZS",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter opening balance",
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          autofocus: true,
                          onSaved: (value) => openingBalance = value!,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                const Text("Vendor notes"),
                SizedBox(height: 4.h),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 0.3),
                    ),
                  ),
                  maxLines: 3,
                  onSaved: (value) => notes = value!,
                  keyboardType: TextInputType.name,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();

              vendorNotifier.updateAdditionalDetails(
                openingBalance: double.parse(openingBalance),
                notes: notes,
              );
            }
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primary),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: const Text("Save details"),
        ),
      ),
    );
  }
}
