import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/customer.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/utils/phone_number_formater.dart';

class InvoiceCustomerDetails extends StatefulWidget {
  const InvoiceCustomerDetails({
    super.key,
    required this.customer,
  });

  final Customer customer;

  @override
  State<InvoiceCustomerDetails> createState() => _InvoiceCustomerDetailsState();
}

class _InvoiceCustomerDetailsState extends State<InvoiceCustomerDetails> {
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
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )),
        leadingWidth: 100,
        title: const Text(
          "Add",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Client Balance"),
                  Text(
                      "TZS ${NumberFormat().format(widget.customer.openingBalance)}"),
                ],
              ),
              SizedBox(height: 18.h),
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextButton(
            onPressed: () async {
              Customer customer = Customer();
              Navigator.pop(context, customer);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(red),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Remove Customer"),
          ),
        ),
      ),
    );
  }
}
