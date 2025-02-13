import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/product_info.dart';
import 'package:zaccount/models/product_item.dart';
import 'package:zaccount/presentation/providers/order_provider.dart';

class ProductOrderDetails extends ConsumerStatefulWidget {
  const ProductOrderDetails({super.key, required this.productInfo});
  final ProductInfo productInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductOrderDetailsState();
}

class _ProductOrderDetailsState extends ConsumerState<ProductOrderDetails> {
  String dateSelected = DateFormat.yMMMMd('en_US').format(DateTime.now());
  DateTime submittedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool productDetailstouched = false;
  bool isSaving = false;
  String sku = "";
  double salingPrice = 0.0;
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
    final product = widget.productInfo;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                color: Theme.of(context).primaryColor,
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
                  initialValue: product.sku,
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
                    fillColor: Theme.of(context).colorScheme.surface,
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
                  initialValue: product.stockQuantity.toString(),
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
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => quantity = int.parse(value!),
                ),
                SizedBox(height: 24.h),
                const Text("Sale price"),
                SizedBox(height: 6.h),
                TextFormField(
                  initialValue: product.salesPrice.toString(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.arrow_up_circle,
                      color: Colors.grey,
                      size: 22,
                    ),
                    hintText: "Enter saling price",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => salingPrice = double.parse(value!),
                ),
                SizedBox(height: 24.h),
                const Text("Quanity"),
                SizedBox(height: 6.h),
                TextFormField(
                  initialValue: "1",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.arrow_up_circle,
                      color: Colors.grey,
                      size: 22,
                    ),
                    hintText: "Enter quantity",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => quantity = int.parse(value!),
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
                          Theme.of(context).colorScheme.surface,
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
                      child: Text(
                        dateSelected,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();

              setState(() {
                isSaving = true;
              });
              try {
                ref.read(orderProvider.notifier).updateproductItem(
                      ProductItem(
                        item: product.name,
                        quantity: quantity,
                        amount: quantity * product.salesPrice,
                        processingDate: submittedDate,
                        rate: product.salesPrice.toInt(),
                        sku: sku,
                      ),
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
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: isSaving
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Text("Add Item"),
        ),
      ),
    );
  }
}
