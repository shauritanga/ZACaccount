import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/utils/constants.dart';

class AddExpenseAccountForm extends StatefulWidget {
  const AddExpenseAccountForm({super.key});

  @override
  State<AddExpenseAccountForm> createState() => _AddExpenseAccountFormState();
}

class _AddExpenseAccountFormState extends State<AddExpenseAccountForm> {
  bool isSaving = false;
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
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        title: Text(
          "Add Expense Account",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leadingWidth: 100.w,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Text("Account Name"),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Transform.flip(
                  flipX: true,
                  child: const Icon(
                    CupertinoIcons.tag,
                  ),
                ),
                hintText: "Enter account name",
                fillColor: Colors.grey.withOpacity(0.3),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          onPressed: () async {
            setState(() {
              isSaving = true;
            });
            try {
              await Future.delayed(
                const Duration(seconds: 2),
              );

              setState(() {
                isSaving = false;
              });
            } catch (e) {
              debugPrint(e.toString());
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
              : const Text("Add Expense Account"),
        ),
      ),
    );
  }
}
