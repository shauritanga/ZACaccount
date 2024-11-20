import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/activity.dart';
import 'package:zaccount/presentation/providers/customer_provider.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/presentation/providers/product_provider.dart';
import 'package:zaccount/presentation/providers/vendo_provider.dart';

final activitiyFutureProvider = FutureProvider<List<Activity>>((ref) async {
  List<Activity> activities = [];
  final customers = await ref.watch(customerStreamProvider.future);
  final vendors = await ref.watch(vendorStreamProvider.future);
  final products = await ref.watch(productStreamProvider.future);
  final invoices = await ref.watch(invoiceStreamProvider.future);
  final expenses = await ref.watch(expenseStreamProvider.future);
  final searchQuery = ref.watch(searchQueryProvider);

  activities.addAll(
    customers.map((customer) {
      return Activity(
        id: customer.id,
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
      dateCreated: product.createdAt,
    );
  }));

  activities.addAll(invoices.map((invoice) {
    return Activity(
      id: invoice.id,
      icon: CupertinoIcons.doc_text,
      type: "invoice",
      name: "Invoice No. ${invoice.invoiceNo}",
      status: invoice.invoiceStatus,
      amount: invoice.balance,
      dateCreated: invoice.invoiceDate,
    );
  }));

  activities.addAll(expenses.map((expense) {
    return Activity(
      id: expense.id,
      icon: CupertinoIcons.money_dollar_circle,
      type: "expense",
      name: expense.referenceNo,
      status: expense.expenseStatus,
      amount: expense.totalAmount,
      dateCreated: expense.dueDate,
    );
  }));

  activities.addAll(vendors.map((vendor) {
    return Activity(
      id: vendor.id,
      icon: CupertinoIcons.person,
      type: "vendor",
      name: vendor.displayName,
      status: "vendor",
      amount: vendor.openingBalance,
      dateCreated: vendor.createdAt,
    );
  }));

  return activities;
});

final searchQueryProvider = StateProvider<String>((ref) => "");
