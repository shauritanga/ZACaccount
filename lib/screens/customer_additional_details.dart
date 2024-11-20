import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/shared/widgets/input_field.dart';

class CustomerAdditionalDetailsScreen extends ConsumerStatefulWidget {
  const CustomerAdditionalDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerAdditionalDetailsScreenState();
}

class _CustomerAdditionalDetailsScreenState
    extends ConsumerState<CustomerAdditionalDetailsScreen> {
  bool _isSubCustomer = false;
  bool _billParentCustomer = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String companyName = "";
  String companyWebsite = "";
  String customerType = "";
  double openingBalance = 0.0;
  String parentId = "";
  String customerNotes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Additional Details"),
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
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  icon: const Icon(Icons.account_balance),
                  hintText: "Enter company name",
                  onSaved: (value) => companyName = value!,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.globe),
                  hintText: "Enter company website(optional)",
                  onSaved: (value) => companyWebsite = value!,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 18.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.tag),
                  hintText: "Enter customer type",
                  onSaved: (value) => customerType = value!,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 18.h),
                CustomTextFormField(
                  icon: const Icon(Icons.money),
                  hintText: "Enter opening balance",
                  onSaved: (value) => openingBalance = double.parse(value!),
                ),
                SizedBox(height: 18.h),
                SwitchListTile(
                  title: const Text("Is Subcustomer"),
                  value: _isSubCustomer,
                  onChanged: (value) {
                    setState(() {
                      _isSubCustomer = value;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.profile_circled),
                  hintText: "Enter parent customer ID",
                  onSaved: (value) => parentId = value!,
                ),
                SizedBox(height: 18.h),
                SwitchListTile(
                  title: const Text("Bill Parent Customer"),
                  value: _billParentCustomer,
                  onChanged: (value) {
                    setState(() {
                      _billParentCustomer = value;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                const Text("Customer notes"),
                SizedBox(height: 8.h),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onSaved: (value) => customerNotes = value!,
                  maxLines: 4,
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
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();
              ref.read(customerProvider.notifier).updateAdditionalDetails(
                    company: companyName,
                    website: companyWebsite,
                    customerType: customerType,
                    openingBalance: openingBalance,
                    parentId: parentId,
                  );
            }
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: const Text("Save details"),
        ),
      ),
    );
  }
}
