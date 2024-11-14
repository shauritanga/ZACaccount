import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/activity.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';

final activitiyFutureProvider = FutureProvider<List<Activity>>((ref) async {
  List<Activity> activities = [];
  final customers = await ref.watch(customerStreamProvider.future);
  final products = await ref.watch(productStreamProvider.future);
  final searchQuery = ref.watch(searchQueryProvider);

  activities.addAll(
    customers.map((customer) {
      return Activity(
        type: "customer",
        name: customer.displayName,
        icon: CupertinoIcons.person,
        amount: customer.openingBalance,
        status: "customer",
      );
    }),
  );

  activities.addAll(products.map((product) {
    return Activity(
      icon: CupertinoIcons.cube_box,
      type: "product",
      name: product.name,
      status: "Quantity ${product.stockQuantity}",
      amount: product.salesPrice,
    );
  }));

  return activities;
});

final searchQueryProvider = StateProvider<String>((ref) => "");
