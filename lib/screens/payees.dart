import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/screens/add_vendor.dart';
import 'package:zaccount/shared/widgets/custom_search_box.dart';
import 'package:zaccount/shared/widgets/customer_tile.dart';

class PayeesScreen extends ConsumerStatefulWidget {
  const PayeesScreen({super.key});

  @override
  ConsumerState<PayeesScreen> createState() => _PayeesScreenState();
}

class _PayeesScreenState extends ConsumerState<PayeesScreen> {
  List<String> get menu => ['All', 'Customers', 'Vendor'];
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(customersFutureProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 230.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.6),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Search",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
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
                                    return const AddVendorScreen(
                                      title: "Add Payee",
                                    ); //whatever you're returning, does not have to be a Container
                                  },
                                );
                              },
                            );
                          },
                          child: Center(
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.6),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomSearchBox(
                      searchTitle: "Search...",
                      deviceWidth: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    width: MediaQuery.sizeOf(context).width,
                    height: 28.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menu.length,
                      itemBuilder: (context, index) {
                        final item = menu[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedTabIndex = index;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                selectedTabIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.1),
                              ),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            child: Text(
                              item,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: selectedTabIndex == index
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          asyncValue.when(
            data: (data) {
              if (data.isEmpty) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "No any data found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Expanded(
                child: Container(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final customer = data[index];
                      return CustomerListTile(
                        customerName: customer.displayName,
                        email: customer.email,
                        phone: customer.phone,
                        onTap: () {
                          ref
                              .read(expenseProvider.notifier)
                              .updatePayee(customer.displayName);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const CupertinoActivityIndicator(),
          )
        ],
      ),
    );
  }
}
