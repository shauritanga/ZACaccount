import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/presentation/providers/product_category_provider.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/screens/add_product_category.dart';
import 'package:zaccount/shared/widgets/custom_search_box.dart';

class ProductCategoriesScreen extends ConsumerWidget {
  const ProductCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(productCategoryStreamProvider);
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
                          width: 48,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                              child: Icon(
                            CupertinoIcons.chevron_left_circle_fill,
                            size: 25,
                          )),
                        ),
                      ),
                      Text(
                        "Product Categories",
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
                              builder: (ctx) =>
                                  const AddProductCategoryScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 48,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.add_circled_solid,
                              size: 25,
                            ),
                          ),
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data[index];
                    return ListTile(
                      title: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(category.description),
                      onTap: () {
                        ref
                            .read(productProvider.notifier)
                            .updateProductCategory(category: category);
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
