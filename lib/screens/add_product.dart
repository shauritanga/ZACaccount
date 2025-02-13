import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/screens/add_product_details.dart';
import 'package:zaccount/screens/income_accounts.dart';
import 'package:zaccount/screens/product_categories.dart';
import 'package:zaccount/screens/product_inventory_details.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  bool productDetailstouched = false;
  bool inventoryDetailstouched = false;
  bool productCategoryTouched = false;
  bool incomeAccountTouched = false;
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider);
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
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                decorationColor: Theme.of(context).primaryColor,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
        leadingWidth: 130.w,
        title: Text(
          "Add Product",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              const Text("PRODUCT DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              productDetailstouched
                  ? Column(
                      children: [
                        Row(
                          children: [
                            const Text("Name:"),
                            SizedBox(width: 12.w),
                            Text(product.name),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Cost:"),
                            SizedBox(width: 12.w),
                            Text(NumberFormat().format(product.cost)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("SalePrice:"),
                            SizedBox(width: 12.w),
                            Text(NumberFormat().format(product.salesPrice)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Description:"),
                            SizedBox(width: 12.w),
                            Text(product.description),
                          ],
                        ),
                      ],
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
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
                                return const ProductDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          productDetailstouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Product Details",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 24.h),
              const Text("INVENTORY DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: inventoryDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              inventoryDetailstouched
                  ? Column(
                      children: [
                        Row(
                          children: [
                            const Text("SKU:"),
                            SizedBox(width: 12.w),
                            Text(product.sku),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Quantity:"),
                            SizedBox(width: 12.w),
                            Text(product.stockQuantity.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("As of date:"),
                            SizedBox(width: 12.w),
                            Text(
                              DateFormat.yMMMMd('en_US')
                                  .format(product.asOfDate),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Reorder Point:"),
                            SizedBox(width: 12.w),
                            Text(product.reOrderPoint.toString()),
                          ],
                        ),
                      ],
                    )
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
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
                                return const ProductInventoryDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          inventoryDetailstouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Inventory Details",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 24.h),
              const Text("PRODUCT CATEGORY DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              productCategoryTouched && product.category.name.isNotEmpty
                  ? Text(product.category.name)
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (ctx) => const ProductCategoriesScreen(),
                          ),
                        );
                        setState(() {
                          productCategoryTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Category",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              SizedBox(height: 24.h),
              const Text("INCOME ACCOUNT"),
              SizedBox(height: 8.h),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
              incomeAccountTouched
                  ? Text(product.incomeAccount)
                  : TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (ctx) => const IncomeAccountsScreen(),
                          ),
                        );

                        setState(() {
                          incomeAccountTouched = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        "Add Income Account",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Divider(
                height: 0,
                indent: productDetailstouched ? 0 : 44.w,
                thickness: 0.3,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: TextButton(
          onPressed: () async {
            setState(() {
              isSaving = true;
            });
            try {
              final result =
                  await ref.read(productProvider.notifier).addProduct();
              setState(() {
                isSaving = false;
                if (result.isNotEmpty) {}
              });
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: isSaving
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Text("Add Product"),
        ),
      ),
    );
  }
}
