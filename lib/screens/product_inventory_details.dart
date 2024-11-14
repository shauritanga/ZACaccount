import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/utils/constants.dart';

class ProductInventoryDetailsForm extends ConsumerStatefulWidget {
  const ProductInventoryDetailsForm({super.key});

  @override
  ConsumerState<ProductInventoryDetailsForm> createState() =>
      _ProductInventoryDetailsFormState();
}

class _ProductInventoryDetailsFormState
    extends ConsumerState<ProductInventoryDetailsForm> {
  String dateSelected = DateFormat.yMMMMd('en_US').format(DateTime.now());
  DateTime submittedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool productDetailstouched = false;
  bool isSaving = false;
  String sku = "";
  int quantity = 0;
  int reorder = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        dateSelected = DateFormat.yMMMMd('en_US').format(picked);
        submittedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: primary,
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
        leadingWidth: 100.w,
        title: Text(
          "Inventory Details",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                const Text("SKU"),
                SizedBox(height: 6.h),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.barcode,
                      color: Colors.grey,
                      size: 22,
                    ),
                    hintText: "Enter SKU",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => sku = value!,
                ),
                SizedBox(height: 24.h),
                const Text("Stock Quantity"),
                SizedBox(height: 6.h),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.list_bullet,
                      color: Colors.grey,
                      size: 22,
                    ),
                    hintText: "Enter stock quantity",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => quantity = int.parse(value!),
                ),
                SizedBox(height: 24.h),
                const Text("Reorder point(Qty)"),
                SizedBox(height: 6.h),
                TextFormField(
                  initialValue: "0",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.arrow_up_circle,
                      color: Colors.grey,
                      size: 22,
                    ),
                    hintText: "Enter reorder point",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => reorder = int.parse(value!),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    const Expanded(child: Text("Track inventory as of:")),
                    TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade200,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          Colors.black,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(dateSelected),
                    )
                  ],
                )
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
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();

              setState(() {
                isSaving = true;
              });
              try {
                ref.read(productProvider.notifier).updateInventoryDetails(
                      sku: sku,
                      stockQuantity: quantity,
                      reorderPoint: reorder,
                      asOfDate: submittedDate,
                    );

                setState(() {
                  isSaving = false;
                });
                Navigator.pop(context);
              } catch (e) {
                debugPrint(e.toString());
              }
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primary),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: isSaving
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Text("Save Inventory Details"),
        ),
      ),
    );
  }
}
