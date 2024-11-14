import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/models/vendor.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';
import 'package:zaccount/utils/constants.dart';

class VendorBankDetailsForm extends ConsumerStatefulWidget {
  const VendorBankDetailsForm({this.vendor, super.key});
  final Vendor? vendor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendorBankDetailsFormState();
}

class _VendorBankDetailsFormState extends ConsumerState<VendorBankDetailsForm> {
  String accountName = "";
  String accountNumber = "";
  String routingNumber = "";
  String nameOnChecks = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vendorNotifier = ref.watch(vendorProviderNotifier.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Bank Details"),
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
                  initialValue: widget.vendor?.accountName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                    hintText: "Enter account name",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => accountName = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.vendor?.accountNo,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.number,
                      color: Colors.grey,
                    ),
                    hintText: "Enter account number",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => accountNumber = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.vendor?.routingNo,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.arrow_branch,
                      color: Colors.grey,
                    ),
                    hintText: "Enter routing number",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => routingNumber = value!,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.vendor?.nameOnChecks,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(190, 233, 233, 233),
                    prefixIcon: const Icon(
                      CupertinoIcons.check_mark_circled,
                      color: Colors.grey,
                    ),
                    hintText: "Enter name on checks",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) => nameOnChecks = value!,
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

              vendorNotifier.updateBankDetails(
                accountName: accountName,
                accountNumber: accountNumber,
                routingNumber: routingNumber,
                nameOnChecks: nameOnChecks,
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
