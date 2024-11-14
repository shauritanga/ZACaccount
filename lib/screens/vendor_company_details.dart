import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';
import 'package:zaccount/utils/constants.dart';

class VendorCompanyDetailsForm extends ConsumerStatefulWidget {
  const VendorCompanyDetailsForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendorCompanyDetailsFormState();
}

class _VendorCompanyDetailsFormState
    extends ConsumerState<VendorCompanyDetailsForm> {
  String companyName = "";
  String displayName = "";
  String website = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vendorNotifier = ref.watch(vendorProviderNotifier.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Company Details"),
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
              children: [
                SizedBox(height: 18.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      Icons.account_balance_outlined,
                      color: Colors.grey,
                    ),
                    hintText: "Enter company name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => companyName = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                    hintText: "Enter company display name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => displayName = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.globe,
                      color: Colors.grey,
                    ),
                    hintText: "Enter website",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => website = value!,
                  keyboardType: TextInputType.emailAddress,
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

              vendorNotifier.updateVendorDetails(
                name: companyName,
                display: displayName,
                website: website,
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
