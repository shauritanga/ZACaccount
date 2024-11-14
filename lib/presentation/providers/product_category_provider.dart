import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/product_category.dart';

final asyncProductCategoryProvider =
    AsyncNotifierProvider<AsyncProductCategoryNotifier, List<ProductCategory>>(
        () {
  return AsyncProductCategoryNotifier();
});

class AsyncProductCategoryNotifier
    extends AsyncNotifier<List<ProductCategory>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductCategory>> _fetchProducCategories() async {
    QuerySnapshot snapshot =
        await _firestore.collection("product-categories").get();
    List<ProductCategory> productCategories =
        snapshot.docs.map((doc) => ProductCategory.fromDocument(doc)).toList();
    return productCategories;
  }

  @override
  FutureOr<List<ProductCategory>> build() {
    return _fetchProducCategories();
  }

  Future<void> addProductCategory(ProductCategory productCategory) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      await _firestore
          .collection("product-categories")
          .add(productCategory.toJson());
      return _fetchProducCategories();
    });
  }
}
