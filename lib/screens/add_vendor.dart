import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/staff_provider.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';
import 'package:zaccount/screens/vendor_additional_details.dart';
import 'package:zaccount/screens/vendor_address_details.dart';
import 'package:zaccount/screens/vendor_bank_datails.dart';
import 'package:zaccount/screens/vendor_company_details.dart';
import 'package:zaccount/screens/vendor_staff_details.dart';
import 'package:zaccount/utils/constants.dart';

class AddVendorScreen extends ConsumerStatefulWidget {
  const AddVendorScreen({required this.title, super.key});
  final String title;

  @override
  ConsumerState<AddVendorScreen> createState() => _AddVendorScreenState();
}

class _AddVendorScreenState extends ConsumerState<AddVendorScreen> {
  bool companyDetailsTouched = false;
  bool staffDetailsTouched = false;
  bool addressDetailsTouched = false;
  bool bankDetailsTouched = false;
  bool additionalDetailsTouched = false;
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    final vendor = ref.watch(vendorProviderNotifier);
    final staff = ref.watch(staffProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                color: primary,
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leadingWidth: 120.w,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              const Text("COMPANY DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: companyDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              companyDetailsTouched
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text("Company name: ${vendor.companyName}"),
                          Text("Display name: ${vendor.displayName}"),
                          Text("Website: ${vendor.website}"),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return const VendorCompanyDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          companyDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primary,
                      ),
                      label: Text(
                        "Add Company Details",
                        style: GoogleFonts.roboto(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: companyDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 20.h),
              const Text("STAFF DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: staffDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              staffDetailsTouched
                  ? GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return VendorStaffDetailsForm(
                                  staff: staff,
                                ); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          staffDetailsTouched = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text("First name: ${staff.firstName}"),
                          Text("Last name: ${staff.lastName}"),
                          Text("Email address: ${staff.email}"),
                          Text("Phone number: ${staff.phone}"),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return const VendorStaffDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          staffDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primary,
                      ),
                      label: Text(
                        "Add Staff Details",
                        style: GoogleFonts.roboto(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: staffDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 20.h),
              const Text("ADDRESS DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: addressDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              addressDetailsTouched
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text("Street: ${vendor.address.street}"),
                          Text("Unit Nmumber: ${vendor.address.unitNumber}"),
                          Text("City: ${vendor.address.city}"),
                          Text("Country: ${vendor.address.country}"),
                          Text("Zipcode: ${vendor.address.zipCode}"),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return const VendorAddressDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          addressDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primary,
                      ),
                      label: Text(
                        "Add Address",
                        style: GoogleFonts.roboto(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: addressDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 20.h),
              const Text("BANK DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: bankDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              bankDetailsTouched
                  ? GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return VendorBankDetailsForm(
                                  vendor: vendor,
                                ); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          bankDetailsTouched = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text("Account name: ${vendor.accountName}"),
                          Text("Account number: ${vendor.accountNo}"),
                          Text("Routing number: ${vendor.routingNo}"),
                          Text("Name on checks: ${vendor.nameOnChecks}"),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return const VendorBankDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          bankDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primary,
                      ),
                      label: Text(
                        "Add Bank Details",
                        style: GoogleFonts.roboto(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: bankDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 20.h),
              const Text("ADDITIONAL DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: additionalDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              additionalDetailsTouched
                  ? GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return VendorAdditionalDetailsForm(
                                  vendor: vendor,
                                ); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          additionalDetailsTouched = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text("Opening balance: TZS ${vendor.openingBalance}"),
                          Text("Notes: ${vendor.notes}"),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return const VendorAdditionalDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          additionalDetailsTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primary,
                      ),
                      label: Text(
                        "Add Other Details",
                        style: GoogleFonts.roboto(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: additionalDetailsTouched ? 0 : 44.w,
                thickness: 0.3,
              ),
            ],
          ),
        ),
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
              final res = await ref
                  .read(vendorProviderNotifier.notifier)
                  .saveVendor(vendor);
              if (res.isNotEmpty) {
                await ref.read(staffProvider.notifier).saveStaff(staff);
              }
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
              : const Text("Add Vendor"),
        ),
      ),
    );
  }
}
