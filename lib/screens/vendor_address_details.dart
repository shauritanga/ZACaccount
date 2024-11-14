import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';
import 'package:zaccount/utils/constants.dart';

class VendorAddressDetailsForm extends ConsumerStatefulWidget {
  const VendorAddressDetailsForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendorAddressDetailsFormState();
}

class _VendorAddressDetailsFormState
    extends ConsumerState<VendorAddressDetailsForm> {
  String street = "";
  String unitNumber = "";
  String city = "";
  String country = "";
  String zipcode = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vendorNotifier = ref.watch(vendorProviderNotifier.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Address Details"),
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
                      CupertinoIcons.map_pin_ellipse,
                      color: Colors.grey,
                    ),
                    hintText: "Enter line 1 name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => street = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.number,
                      color: Colors.grey,
                    ),
                    hintText: "Enter unit/apt number(optional)",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => unitNumber = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: Colors.grey,
                    ),
                    hintText: "Enter city name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => city = value!,
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
                    hintText: "Enter country name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => country = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.location_fill,
                      color: Colors.grey,
                    ),
                    hintText: "Enter zipcode(optional)",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => zipcode = value!,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
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

              vendorNotifier.updateAddressDetails(
                street: street,
                unitNumber: unitNumber,
                city: city,
                country: country,
                zipcode: zipcode,
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
