import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/activity_provider.dart';
import 'package:zaccount/presentation/providers/home_provider.dart';
import 'package:zaccount/screens/customer_details.dart';
import 'package:zaccount/screens/invoice_details.dart';
import 'package:zaccount/screens/product_details.dart';
import 'package:zaccount/shared/widgets/custom_list_item.dart';
import 'package:zaccount/shared/widgets/custom_search_box.dart';

class ActivitiesPage extends ConsumerStatefulWidget {
  const ActivitiesPage({super.key});

  @override
  ConsumerState<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends ConsumerState<ActivitiesPage> {
  String selectedItem = "All";

  List<String> get items =>
      ['All', 'Invoice', 'Expense', 'Product', 'Customer', 'Vendor'];

  int selectedTabIndex = 0;

  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(activitiyFutureProvider);
    final searchProvider = ref.watch(searchQueryProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 5),
            height: 220.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7)
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref.read(homeProvider.notifier).updateCurrentTab(0);
                          },
                          child: Container(
                            width: 50.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            child: Center(
                              child: Container(
                                width: 25.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 2, 33, 80)
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                    size: 18.r,
                                  ),
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
                            ref.read(homeProvider.notifier).updateCurrentTab(3);
                          },
                          child: Container(
                            width: 50.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Container(
                                width: 25.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 2, 33, 80)
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.settings,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomSearchBox(
                      controller: _searchTextController,
                      deviceWidth: MediaQuery.sizeOf(context).width,
                      onChanged: (text) {
                        ref.read(searchQueryProvider.notifier).state =
                            _searchTextController.text;
                      },
                    ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 30.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = index;
                              selectedItem =
                                  items[index] == "All" ? "" : items[index];
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: selectedTabIndex == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                item,
                                style: GoogleFonts.roboto(
                                  color: selectedTabIndex == index
                                      ? Colors.black
                                      : Colors.white,
                                ),
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
          Expanded(
            child: asyncValue.when(
              data: (data) {
                if (data.isEmpty) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900,
                          offset: const Offset(0, 1),
                          blurRadius: 1.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "No any data found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final activities = data
                    .where((activity) =>
                        activity.name
                            .toLowerCase()
                            .contains(searchProvider.toLowerCase()) &&
                        activity.type
                            .toLowerCase()
                            .contains(selectedItem.toLowerCase()))
                    .toList();

                if (activities.isEmpty) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "No any activity found by",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];
                      return Column(
                        children: [
                          CustomListItem(
                            dateCreated: activity.dateCreated,
                            icon: activity.icon,
                            color: activity.type.toLowerCase() == "product"
                                ? Theme.of(context).colorScheme.secondary
                                : activity.type.toLowerCase() == "customer"
                                    ? Colors.purple
                                    : Colors.black,
                            title: activity.name,
                            status: activity.status,
                            amount: activity.amount,
                            statusColor: activity.type.toLowerCase() ==
                                        "product" ||
                                    activity.type.toLowerCase() == "customer"
                                ? Colors.purple
                                : activity.type.toLowerCase() == "invoice"
                                    ? Colors.blue
                                    : Colors.black,
                            onTap: () {
                              if (activity.type == "product") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const ProductDetails(),
                                  ),
                                );
                                return;
                              }

                              if (activity.type == "customer") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => CustomerDetailsScreen(
                                        customerId: activity.id),
                                  ),
                                );
                                return;
                              }

                              if (activity.type == "vendor") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => CustomerDetailsScreen(
                                        customerId: activity.id),
                                  ),
                                );
                                return;
                              }

                              if (activity.type == "invoice") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => InvoiceDetails(
                                      invoiceId: activity.id,
                                    ),
                                  ),
                                );
                                return;
                              }
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
              loading: () => const CupertinoActivityIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
