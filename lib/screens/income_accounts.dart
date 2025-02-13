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
  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(incomeAccountStreamProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.7],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: const Center(
                              child: Icon(
                            CupertinoIcons.chevron_left,
                            size: 18,
                          )),
                        ),
                      ),
                      Text(
                        "Income accounts",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (ctx) => const AddIncomeAccountScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: const Center(
                              child: Icon(
                            CupertinoIcons.add,
                            size: 18,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomSearchBox(
                      searchTitle: "Search...",
                      deviceWidth: MediaQuery.sizeOf(context).width),
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
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
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
