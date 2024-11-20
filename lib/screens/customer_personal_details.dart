import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/shared/widgets/input_field.dart';

class CustomerPersonalDetailsForm extends ConsumerStatefulWidget {
  const CustomerPersonalDetailsForm({super.key});

  @override
  ConsumerState<CustomerPersonalDetailsForm> createState() =>
      _CustomerPersonalDetailsFormState();
}

class _CustomerPersonalDetailsFormState
    extends ConsumerState<CustomerPersonalDetailsForm> {
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String displayName = "";
  String email = "";
  String phone = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Personal Details",
                      style: GoogleFonts.roboto(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.clear,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.person),
                  hintText: "Enter first name",
                  onSaved: (value) => firstName = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter first name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.person),
                  hintText: "Enter middle name(optional)",
                  onSaved: (value) => middleName = value!,
                  validator: (value) {
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.person),
                  hintText: "Enter last name",
                  onSaved: (value) => lastName = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter last name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.person_2),
                  hintText: "Enter display name",
                  onSaved: (value) => displayName = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter display name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.envelope),
                  hintText: "Enter email address",
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.phone),
                  hintText: "0xxx-xxx-xxx",
                  onSaved: (value) => phone = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your phone nuumber";
                    }
                    return null;
                  },
                  inputFormatters: [
                    MaskedInputFormatter("0000 000 000"),
                  ],
                  keyboardType: TextInputType.name,
                ),
                const Text(""),
                SizedBox(
                  height: 270.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: TextButton(
            onPressed: () {
              debugPrint("hi");
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                customer.updatePesonalDetails(
                  firstName: firstName,
                  middleName: middleName,
                  lastName: lastName,
                  displayName: displayName,
                  email: email,
                  phone: phone,
                );
              }
              Navigator.pop(context);
            },
            style: ButtonStyle(
              minimumSize: const WidgetStatePropertyAll(
                Size(double.infinity, 40),
              ),
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            child: const Text("Save Details"),
          ),
        ),
      ),
    );
  }
}
