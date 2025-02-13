import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaccount/presentation/providers/product_category_provider.dart';

class AddProductCategoryScreen extends ConsumerStatefulWidget {
  const AddProductCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState
    extends ConsumerState<AddProductCategoryScreen> {
  bool isSaving = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> updateImage(File image) async {
    Reference storageRef =
        _storage.ref().child("product-categories").child("/images");
    TaskSnapshot snapshot = await storageRef.putFile(image);
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  String name = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              decorationColor: Theme.of(context).primaryColor,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        title: const Text(
          "Add Product Category",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const Text("Category Details"),
                SizedBox(height: 10.h),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter category name",
                    prefixIcon: Transform.flip(
                      flipX: true,
                      child: const Icon(CupertinoIcons.tag),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(100, 18, 18, 18),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter category name please";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 28.h),
                TextFormField(
                  onTap: () async {
                    ImagePicker picker = ImagePicker();
                    XFile? pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    debugPrint(pickedImage?.path);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pick an image",
                    prefixIcon: Transform.flip(
                      flipX: true,
                      child: const Icon(CupertinoIcons.photo),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(100, 18, 18, 18),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.white38,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.white38,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSaved: (value) => description = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter description please";
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();

                setState(() {
                  isSaving = true;
                });
                try {
                  ref.read(productCategoryProvider.notifier).addProductCategory(
                      name: name, description: description, image: "");

                  setState(() {
                    isSaving = false;
                  });
                  Navigator.pop(context);
                } catch (e) {
                  setState(() {
                    isSaving = false;
                  });
                  debugPrint(e.toString());
                }
              }
            },
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CupertinoActivityIndicator()
                : const Text("Add Product Category"),
          ),
        ),
      ),
    );
  }
}
