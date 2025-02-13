import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/screens/add_shipping_address.dart';
import 'package:zaccount/screens/customer_additional_details.dart';
import 'package:zaccount/screens/customer_personal_details.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  ConsumerState<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends ConsumerState<AddCustomerScreen> {
  bool personalDetailsTouched = false;
  bool shippingAddressTouched = false;
  bool otherDetailsTouched = false;
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProvider);
    final customerNotifier = ref.watch(customerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            customerNotifier.updatePesonalDetails(
              firstName: "",
              middleName: "",
              lastName: "",
              displayName: "",
              email: "",
              phone: "",
            );
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
        title: Text(
          "Add Customer",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leadingWidth: 130.w,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              const Text("PERSONAL DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                indent: personalDetailsTouched ? 0 : 44.w,
                height: 0,
              ),
              personalDetailsTouched
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Firstname:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.firstName),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Middlename:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.middleName),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Lastname:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.lastName),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Display Name:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.displayName),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Email:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.email),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Phone:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.phone),
                          ],
                        ),
                      ],
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          builder: (BuildContext context) {
                            return DraggableScrollableSheet(
                              initialChildSize: 1.0, //set this as you want
                              maxChildSize: 1.0, //set this as you want
                              minChildSize: 1.0, //set this as you want
                              expand: true,
                              builder: (context, scrollController) {
                                return const CustomerPersonalDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          personalDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Personal Details",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                indent: personalDetailsTouched ? 0 : 44.w,
                height: 0,
              ),
              SizedBox(height: 40.h),
              const Text("SHIPPING ADDRESS"),
              SizedBox(height: 8.h),
              Divider(
                indent: shippingAddressTouched ? 0 : 44.w,
                height: 0,
              ),
              shippingAddressTouched
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Street:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text("${customer.shippingAddress?.street}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Unit:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text("${customer.shippingAddress?.unitNumber}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "City:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text("${customer.shippingAddress?.city}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Region:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text("${customer.shippingAddress?.country}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "zipcode:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text("${customer.shippingAddress?.zipCode}"),
                          ],
                        ),
                      ],
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          builder: (BuildContext context) {
                            return DraggableScrollableSheet(
                              initialChildSize: 1.0, //set this as you want
                              maxChildSize: 1.0, //set this as you want
                              minChildSize: 1.0, //set this as you want
                              expand: true,
                              builder: (context, scrollController) {
                                return const CustomerShippingAddressForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          shippingAddressTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Address",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(indent: shippingAddressTouched ? 0 : 44.w, height: 0),
              SizedBox(height: 40.h),
              const Text(
                "ADDITIONAL DETAILS",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(
                indent: otherDetailsTouched ? 0 : 44.w,
                height: 0,
              ),
              otherDetailsTouched
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Company Name:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.companyName),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Website:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.website),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Customer Type:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.customerType),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Opening Balance:",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(customer.openingBalance.toString()),
                          ],
                        ),
                      ],
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          builder: (BuildContext context) {
                            return DraggableScrollableSheet(
                              initialChildSize: 1.0, //set this as you want
                              maxChildSize: 1.0, //set this as you want
                              minChildSize: 1.0, //set this as you want
                              expand: true,
                              builder: (context, scrollController) {
                                return const CustomerAdditionalDetailsScreen(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          otherDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Other Details",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                indent: otherDetailsTouched ? 0 : 44.w,
                height: 0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextButton(
            onPressed: () async {
              setState(() {
                isSaving = true;
              });
              String result =
                  await ref.read(customerProvider.notifier).addCustomer();
              setState(() {
                isSaving = false;
              });
              if (result.isEmpty) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("failed, try again"),
                  ),
                );
                return;
              }

              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Customer created successfully"),
                ),
              );
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CupertinoActivityIndicator(color: Colors.white)
                : const Text("Add Customer"),
          ),
        ),
      ),
    );
  }
}
