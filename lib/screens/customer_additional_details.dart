import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/models/customer_tag.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String companyName = "";
  String companyWebsite = "";
  String? customerType;
  String customerNotes = "";

  Future<List<CustomerTag>> getCustomerTags() async {
    QuerySnapshot snapshot = await _firestore.collection("customer-tags").get();
    List<CustomerTag> tags =
        snapshot.docs.map((doc) => CustomerTag.fromMap(doc)).toList();

    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                const SizedBox(height: 18),
                FutureBuilder<List<CustomerTag>>(
                    future: getCustomerTags(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(),
                            ),
                            child: DropdownButton(
                              value: customerType,
                              hint: const Text('Select customer type'),
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data!.map((item) {
                                return DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.name),
                                );
                              }).toList(),
                              dropdownColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              onChanged: (value) {
                                customerType = value!;
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    }),
                const SizedBox(height: 18),
                CustomTextFormField(
                  icon: const Icon(Icons.account_balance),
                  hintText: "Enter company name",
                  onSaved: (value) => companyName = value!,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.globe),
                  hintText: "Enter company website",
                  onSaved: (value) => companyWebsite = value!,
                  keyboardType: TextInputType.emailAddress,
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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();
                ref.read(customerProvider.notifier).updateAdditionalDetails(
                      company: companyName,
                      website: companyWebsite,
                      customerType: customerType.toString(),
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
      ),
    );
  }
}
