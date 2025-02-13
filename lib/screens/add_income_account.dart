import 'package:cloud_firestore/cloud_firestore.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";

  late Color backgroundColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    backgroundColor = Theme.of(context).primaryColor;
  }

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
            key: _formKey,
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
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Account name is required";
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                setState(() {
                  isSaving = true;
                });
                try {
                  final DocumentReference reference = await FirebaseFirestore
                      .instance
                      .collection("income-accounts")
                      .add({"name": name});
                  if (reference.id.isNotEmpty) {
                    setState(() {
                      isSaving = false;
                      backgroundColor = Colors.green;
                    });
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      isSaving = false;
                      backgroundColor = Colors.red;
                    });
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(backgroundColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CupertinoActivityIndicator()
                : const Text("Add Income Account"),
          ),
        ),
      ),
    );
  }
}
