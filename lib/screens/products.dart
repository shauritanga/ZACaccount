import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/product_item.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/screens/add_product.dart';
import 'package:zaccount/screens/product_tag.dart';
import 'package:zaccount/shared/widgets/custom_search_bar.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(productStreamProvider);
    final asynTags = ref.watch(productTagProvider);
    return Scaffold(
      body: Column(
        children: [
          CustomerHeaderWithSearchAndTab(
            title: "Products",
            widgetToNavigate: const AddProductScreen(),
            menu: asynTags,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const ProductTagForm(),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final product = data[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              dense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.w),
                              leading: Icon(
                                CupertinoIcons.cube_box,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.barcode,
                                    size: 13,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(product.sku),
                                  SizedBox(width: 8.w),
                                  Container(
                                    width: 1.5,
                                    height: 13,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                      "Price: Tsh ${NumberFormat().format(product.salesPrice)}")
                                ],
                              ),
                              onTap: () {
                                ref
                                    .read(expenseProvider.notifier)
                                    .updateproductItem(
                                      ProductItem(
                                        amount: product.salesPrice,
                                        sku: product.sku,
                                        quantity: 1,
                                        item: product.name,
                                      ),
                                    );
                                Navigator.pop(context, product);
                              },
                            ),
                            const Divider(
                              height: 0,
                              indent: 16,
                              endIndent: 16,
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
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
