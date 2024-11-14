import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/models/staff.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';
import 'package:zaccount/utils/constants.dart';

class VendorStaffDetailsForm extends ConsumerStatefulWidget {
  const VendorStaffDetailsForm({this.staff, super.key});

  final StaffDetails? staff;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendorStaffDetailsFormState();
}

class _VendorStaffDetailsFormState
    extends ConsumerState<VendorStaffDetailsForm> {
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String displayName = "";
  String email = "";
  String phone = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vendorNotifier = ref.watch(vendorProviderNotifier.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Staff Details"),
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
                  initialValue: widget.staff?.firstName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.grey,
                    ),
                    hintText: "Enter first name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => firstName = value!,
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
                    hintText: "Enter middle name(optional)",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => middleName = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.staff?.lastName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.grey,
                    ),
                    hintText: "Enter last name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => lastName = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.grey,
                    ),
                    hintText: "Enter display name",
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
                      CupertinoIcons.envelope,
                      color: Colors.grey,
                    ),
                    hintText: "Enter email address",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => email = value!,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.phone,
                      color: Colors.grey,
                    ),
                    hintText: "0xxx-xxx-xxx",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => phone = value!,
                  inputFormatters: [MaskedInputFormatter("0000-000-000")],
                  keyboardType: TextInputType.phone,
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

              vendorNotifier.updateStaff(
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
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
