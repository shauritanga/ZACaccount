import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/customer.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/utils/phone_number_formater.dart';

class CustomerDetailsScreen extends ConsumerStatefulWidget {
  const CustomerDetailsScreen({required this.customerId, super.key});

  final String customerId;

  @override
  ConsumerState<CustomerDetailsScreen> createState() =>
      _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends ConsumerState<CustomerDetailsScreen> {
  bool isSaving = false;
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final customerAsync = ref.watch(customerFutureProvider(widget.customerId));

    return customerAsync.when(
        data: (data) {
          final customer = data;
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
                customer.displayName,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              leadingWidth: 100.w,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.phone_fill,
                    color: primary,
                  ),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.displayName,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            customer.email,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Open Balance",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                              "TZS ${NumberFormat().format(customer.openingBalance)}"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentTabIndex = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(
                                0.3,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Details",
                                  style: GoogleFonts.roboto(
                                    color: currentTabIndex == 0
                                        ? Colors.black
                                        : const Color.fromARGB(255, 92, 92, 92),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 5,
                                  width: double.infinity,
                                  color: currentTabIndex == 0
                                      ? primary
                                      : const Color.fromARGB(
                                          255, 135, 135, 135),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentTabIndex = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(
                                0.3,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Transactions",
                                  style: GoogleFonts.roboto(
                                    color: currentTabIndex == 1
                                        ? Colors.black
                                        : const Color.fromARGB(255, 92, 92, 92),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 5,
                                  width: double.infinity,
                                  color: currentTabIndex == 1
                                      ? primary
                                      : const Color.fromARGB(
                                          255, 135, 135, 135),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: [
                    Details(
                      customer: customer,
                    ),
                    const Transactions()
                  ][currentTabIndex],
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Scaffold(
              body: Center(
                child: Text(error.toString()),
              ),
            ),
        loading: () => const Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(),
              ),
            ));
  }
}

class Transactions extends StatelessWidget {
  const Transactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          DottedBorder(
            padding: const EdgeInsets.all(6),
            borderType: BorderType.Circle,
            color: primary,
            child: Center(
              child: Icon(
                CupertinoIcons.arrow_down,
                size: 25,
                color: primary,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          const Text("Customer's activities will appear here"),
        ],
      ),
    );
  }
}

class Details extends StatefulWidget {
  const Details({
    super.key,
    required this.customer,
  });

  final Customer customer;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("CONTACT INFORMATION"),
              SizedBox(height: 8.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.person),
                  SizedBox(width: 12.w),
                  Text(
                      "${widget.customer.firstName} ${widget.customer.lastName}"),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.envelope),
                  SizedBox(width: 12.w),
                  Text(widget.customer.email),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.phone),
                  SizedBox(width: 12.w),
                  Text(formatPhoneNumber(widget.customer.phone)),
                ],
              ),
              SizedBox(height: 32.h),
              const Text("BILLING ADDRESS"),
              SizedBox(height: 8.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.map_pin_ellipse),
                  SizedBox(width: 12.w),
                  Text(widget.customer.billingAddress!.street),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.number),
                  SizedBox(width: 12.w),
                  Text(widget.customer.billingAddress!.unitNumber),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(HugeIcons.strokeRoundedCity01),
                  SizedBox(width: 12.w),
                  Text(widget.customer.billingAddress!.city),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.map_pin_ellipse),
                  SizedBox(width: 12.w),
                  Text(widget.customer.billingAddress!.zipCode),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.globe),
                  SizedBox(width: 12.w),
                  Text(widget.customer.billingAddress!.country),
                ],
              ),
              SizedBox(height: 32.h),
              const Text("SHIPPING ADDRESS"),
              SizedBox(height: 8.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.map_pin_ellipse),
                  SizedBox(width: 12.w),
                  Text(widget.customer.shippingAddress!.street),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.number),
                  SizedBox(width: 12.w),
                  Text(widget.customer.shippingAddress!.unitNumber),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(HugeIcons.strokeRoundedCity01),
                  SizedBox(width: 12.w),
                  Text(widget.customer.shippingAddress!.city),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.map_pin_ellipse),
                  SizedBox(width: 12.w),
                  Text(widget.customer.shippingAddress!.zipCode),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(CupertinoIcons.globe),
                  SizedBox(width: 12.w),
                  Text(widget.customer.shippingAddress!.country),
                ],
              ),
              SizedBox(height: 32.h),
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
              : const Text("Edit Customer"),
        ),
      ),
    );
  }
}
