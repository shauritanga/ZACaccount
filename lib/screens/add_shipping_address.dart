import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/widgets/input_field.dart';

class CustomerShippingAddressForm extends ConsumerStatefulWidget {
  const CustomerShippingAddressForm({super.key});

  @override
  ConsumerState<CustomerShippingAddressForm> createState() =>
      _CustomerShippingAddressFormState();
}

class _CustomerShippingAddressFormState
    extends ConsumerState<CustomerShippingAddressForm> {
  bool sameAddress = true;
  String lineOneName = "";
  String unit = "";
  String city = "";
  String country = "";
  String zipCode = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Address Details",
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
                const Text("Shipping Address"),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.map_pin_ellipse),
                  hintText: "Enter line 1 name",
                  onSaved: (value) => lineOneName = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 22.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.number),
                  hintText: "Enter unit/Apt number(optional)",
                  onSaved: (value) => unit = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 22.h),
                CustomTextFormField(
                  icon: const Icon(Icons.location_city),
                  hintText: "Enter city name",
                  onSaved: (value) => city = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 22.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.globe),
                  hintText: "Enter country name",
                  onSaved: (value) => country = value!,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 22.h),
                CustomTextFormField(
                  icon: const Icon(CupertinoIcons.location),
                  hintText: "Enter zipcode(optional)",
                  onSaved: (value) => zipCode = value!,
                  keyboardType: TextInputType.name,
                ),
                SwitchListTile(
                  title: const Text("Billing address sama as shipping"),
                  value: sameAddress,
                  onChanged: (value) {
                    setState(() {
                      sameAddress = value;
                    });
                  },
                ),
                sameAddress
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(height: 22.h),
                          CustomTextFormField(
                            icon: const Icon(CupertinoIcons.globe),
                            hintText: "Enter country name",
                            onSaved: (value) => country = value!,
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 22.h),
                          CustomTextFormField(
                            icon: const Icon(CupertinoIcons.location),
                            hintText: "Enter zipcode(optional)",
                            onSaved: (value) => zipCode = value!,
                            keyboardType: TextInputType.name,
                          ),
                        ],
                      ),
                SizedBox(
                  height: sameAddress ? 260.h : 104.h,
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
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();
                ref.read(customerProvider.notifier).updateShppingAddress(
                      street: lineOneName,
                      unit: unit,
                      city: city,
                      country: country,
                      zipcode: zipCode,
                    );
              }

              Navigator.pop(context);
            },
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(
                Size(double.infinity, 40.h),
              ),
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r)),
              ),
            ),
            child: const Text("Save Details"),
          ),
        ),
      ),
    );
  }
}
