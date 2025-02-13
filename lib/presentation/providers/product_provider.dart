import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/customer_tag.dart';
import 'package:zaccount/models/product_category.dart';
import 'package:zaccount/models/product_info.dart';

final productStreamProvider = StreamProvider<List<ProductInfo>>((ref) {
  return FirebaseFirestore.instance.collection('products').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => ProductInfo.fromDocument(doc)).toList(),
      );
});
final productProvider =
    StateNotifierProvider<ProductNotifier, ProductInfo>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<ProductInfo> {
  ProductNotifier() : super(ProductInfo());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateProductDetails({
    String productName = "",
    double cost = 0,
    double salePrice = 0,
    String description = "",
  }) {
    state = state.copyWith(
      name: productName,
      cost: cost,
      salesPrice: salePrice,
      description: description,
    );
  }

  void updateInventoryDetails({
    String sku = "",
    int stockQuantity = 0,
    int reorderPoint = 0,
    DateTime? asOfDate,
  }) {
    state = state.copyWith(
      sku: sku,
      stockQuantity: stockQuantity,
      reOrderPoint: reorderPoint,
      asOfDate: asOfDate,
    );
  }

  void updateProductCategory({required ProductCategory category}) {
    state = state.copyWith(category: category);
  }

  void updateIncomeAccount({required String incomeAccount}) {
    state = state.copyWith(incomeAccount: incomeAccount);
  }

  Future<String> addProduct() async {
    DocumentReference reference =
        await _firestore.collection("products").add(state.toMap());
    return reference.id;
  }
}

//Customer Tag
final productTagProvider = StreamProvider<List<CustomerTag>>((ref) {
  return FirebaseFirestore.instance.collection('product-tags').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => CustomerTag.fromDocument(doc)).toList(),
      );
});
