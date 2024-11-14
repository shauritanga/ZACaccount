import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zaccount/screens/add_customer.dart';
import 'package:zaccount/screens/add_invoice.dart';
import 'package:zaccount/screens/add_product.dart';
import 'package:zaccount/screens/add_vendor.dart';
import 'package:zaccount/screens/company_details.dart';
import 'package:zaccount/screens/profile.dart';

class ToDoListScreen extends ConsumerStatefulWidget {
  const ToDoListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends ConsumerState<ToDoListScreen> {
  List todos = [
    {
      'title': 'Complete personal details',
      'url': const ProfileScreen(),
    },
    {
      'title': 'Complte company details',
      'url': const CompanyDetailsScreen(),
    },
    {
      'title': 'Create your first invoice',
      'url': const AddInvoiceScreen(),
    },
    {
      'title': 'Add your first product',
      'url': const AddProductScreen(),
    },
    {
      'title': 'Add your first vendor',
      'url': const AddVendorScreen(title: "Vendor"),
    },
    {
      'title': 'Add your first customer',
      'url': const AddCustomerScreen(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        title: const Text("To-Do List"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 32.h),
            CircularPercentIndicator(
              radius: 35.r,
              percent: 0.67,
              startAngle: 90,
              circularStrokeCap: CircularStrokeCap.round,
              lineWidth: 7.0.r,
              center: const Text("67%"),
              progressColor: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 34.h),
            Text(
              "Let's get Started.",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "We're here to assist with setting up",
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 34.h),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => todo['url']));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(todo['title']),
                        CircularPercentIndicator(
                          radius: 25.r,
                          percent: 0.06,
                          startAngle: 90,
                          circularStrokeCap: CircularStrokeCap.round,
                          lineWidth: 5.0.r,
                          center: const Text("6%"),
                          progressColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
