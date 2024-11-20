import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/inccome_account_provider.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/screens/add_income_account.dart';
import 'package:zaccount/shared/widgets/custom_search_box.dart';

class IncomeAccountsScreen extends ConsumerStatefulWidget {
  const IncomeAccountsScreen({super.key});

  @override
  ConsumerState<IncomeAccountsScreen> createState() =>
      _IncomeAccountsScreenState();
}

class _IncomeAccountsScreenState extends ConsumerState<IncomeAccountsScreen> {
  List<String> get menu => ['All', 'New', 'Name', 'Description', 'Archieved'];
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(incomeAccountStreamProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250.h,
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
                            Navigator.pop(context);
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
                          "Income Accounts",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (ctx) =>
                                    const AddIncomeAccountScreen(),
                              ),
                            );
                            //whatever you're returning, does not have to be a Container
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
                                    Icons.add,
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
                      deviceWidth: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 30.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menu.length,
                      itemBuilder: (context, index) {
                        final item = menu[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = index;
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
          asyncValue.when(
            data: (data) {
              if (data.isEmpty) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
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
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: const Offset(0, 1),
                      blurRadius: 1.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final income = data[index];
                    return ListTile(
                      title: Text(
                        income.name,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        ref
                            .read(productProvider.notifier)
                            .updateIncomeAccount(incomeAccount: income.name);
                        Navigator.pop(context);
                      },
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
          )
        ],
      ),
    );
  }
}
