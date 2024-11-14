import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/models/category_item.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/utils/constants.dart';

class AddExpenseServiceDetailsForm extends ConsumerStatefulWidget {
  const AddExpenseServiceDetailsForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddExpenseServiceDetailsFormState();
}

class _AddExpenseServiceDetailsFormState
    extends ConsumerState<AddExpenseServiceDetailsForm> {
  bool isSaving = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? serviceType;
  double? rate;
  int? quanity;
  String? description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: primary,
              decoration: TextDecoration.underline,
              decorationColor: primary,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        leadingWidth: 100.w,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.h),
                const Text("Service Name"),
                SizedBox(height: 8.h),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                    hintText: "Enter service type",
                    hintStyle: GoogleFonts.roboto(color: Colors.grey),
                    prefixIcon: Transform.flip(
                      flipX: true,
                      child: const Icon(CupertinoIcons.tag, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  onSaved: (value) => serviceType = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please type service type";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                const Text("Rate"),
                SizedBox(height: 8.h),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                    hintText: "Enter category rate",
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
                    hintStyle: GoogleFonts.roboto(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  onSaved: (value) => rate = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter rate";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                const Text("Quantity"),
                SizedBox(height: 8.h),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                    prefixIcon: const Icon(
                      CupertinoIcons.number,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  onSaved: (value) => quanity = int.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter quantity";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                const Text("Description(Optional)"),
                SizedBox(height: 8.h),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 3,
                  onSaved: (value) => description = value,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
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
                  ref.read(expenseProvider.notifier).updateCategoryItem(
                        CategoryItem(
                          category: serviceType!,
                          quantity: quanity!,
                          rate: rate!,
                          amount: rate! * quanity!,
                          description: description ?? "",
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
              backgroundColor: WidgetStatePropertyAll(primary),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Add Service"),
          ),
        ),
      ),
    );
  }
}
