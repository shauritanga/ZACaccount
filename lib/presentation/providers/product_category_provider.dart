import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/product_category.dart';

final productCategoryStreamProvider =
    StreamProvider<List<ProductCategory>>((ref) {
  return FirebaseFirestore.instance
      .collection('product-categories')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => ProductCategory.fromDocument(doc))
            .toList(),
      );
});

final productCategoryProvider =
    StateNotifierProvider<ProductCategoryNotifier, ProductCategory>((ref) {
  return ProductCategoryNotifier();
});

class ProductCategoryNotifier extends StateNotifier<ProductCategory> {
  ProductCategoryNotifier() : super(ProductCategory());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> addProductCategory({
    required String name,
    required String description,
    required String image,
  }) async {
    DocumentReference reference = await _firestore
        .collection("product-categories")
        .add(state
            .copyWith(name: name, description: description, image: image)
            .toJson());

    return reference.id;
  }

  Future<void> updateImage(File image) async {
    Reference storageRef =
        _storage.ref().child("product-categories").child(state.id);
    TaskSnapshot snapshot = await storageRef.putFile(image);
    String profilePicUrl = await snapshot.ref.getDownloadURL();
    await _firestore
        .collection("product-categories")
        .doc(state.id)
        .update(({'image': profilePicUrl}));

    state = state.copyWith(image: profilePicUrl);
  }
}
