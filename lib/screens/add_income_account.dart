import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddIncomeAccountScreen extends ConsumerStatefulWidget {
  const AddIncomeAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddIncomeAccountScreenState();
}

class _AddIncomeAccountScreenState
    extends ConsumerState<AddIncomeAccountScreen> {
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              decorationColor: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        title: const Text(
          "Add Income Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            const Text("Account Name"),
            SizedBox(height: 10.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter account name",
                prefixIcon: Transform.flip(
                  flipX: true,
                  child: const Icon(CupertinoIcons.tag),
                ),
                filled: true,
                fillColor: const Color.fromARGB(100, 18, 18, 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
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
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Add Income Account"),
          ),
        ),
      ),
    );
  }
}
