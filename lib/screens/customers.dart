import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/screens/add_customer.dart';
import 'package:zaccount/screens/customer_tag.dart';
import 'package:zaccount/shared/widgets/custom_search_bar.dart';
import 'package:zaccount/shared/widgets/customer_tile.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(customerStreamProvider);
    final customerTagsAsync = ref.watch(customerTagProvider);
    return Scaffold(
      body: Column(
        children: [
          CustomerHeaderWithSearchAndTab(
            title: "Customers",
            menu: customerTagsAsync,
            widgetToNavigate: const AddCustomerScreen(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const CustomerTagForm(),
                ),
              );
            },
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
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final customer = data[index];
                      return CustomerListTile(
                        customerName: customer.displayName,
                        phone: customer.phone,
                        email: customer.email,
                        onTap: () {
                          Navigator.pop(context, customer);
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
