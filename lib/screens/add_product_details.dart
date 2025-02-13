import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/utils/constants.dart';

class ProductDetailsForm extends ConsumerStatefulWidget {
  const ProductDetailsForm({super.key});

  @override
  ConsumerState<ProductDetailsForm> createState() => _ProductDetailsFormState();
}

class _ProductDetailsFormState extends ConsumerState<ProductDetailsForm> {
  String productName = "";
  double productCost = 0.0;
  double sellingPrice = 0.0;
  String description = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
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
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
        leadingWidth: 100.w,
        title: Text(
          "Product Details",
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
                const Text("Product name"),
                SizedBox(height: 6.h),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Transform.flip(
                      flipX: true,
                      child: const Icon(
                        CupertinoIcons.tag,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Enter product name",
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
                  onSaved: (value) => productName = value!,
                ),
                SizedBox(height: 24.h),
                const Text("Product cost"),
                SizedBox(height: 6.h),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "TZS",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: "Enter cost",
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
                  onSaved: (value) => productCost = double.parse(value!),
                ),
                SizedBox(height: 24.h),
                const Text("Sale price"),
                SizedBox(height: 6.h),
                TextFormField(
                  initialValue: "0",
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "TZS",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: "Enter sale price",
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
                  onSaved: (value) => sellingPrice = double.parse(value!),
                ),
                SizedBox(height: 24.h),
                const Text("Description notes"),
                SizedBox(height: 6.h),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    // filled: true,
                    // fillColor: Theme.of(context).colorScheme.surface,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  maxLines: 3,
                  onSaved: (value) => description = value!,
                ),
                SizedBox(height: 24.h),
                const Text("Display image"),
                SizedBox(height: 6.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.photo,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "Upload Image",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SafeArea(
          child: TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();

                setState(() {
                  isSaving = true;
                });

                try {
                  ref.read(productProvider.notifier).updateProductDetails(
                        productName: productName,
                        cost: productCost,
                        salePrice: sellingPrice,
                        description: description,
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
                : const Text("Save Product Details"),
          ),
        ),
      ),
    );
  }
}
