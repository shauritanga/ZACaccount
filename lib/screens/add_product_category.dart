import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddProductCategoryScreen extends ConsumerStatefulWidget {
  const AddProductCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState
    extends ConsumerState<AddProductCategoryScreen> {
  bool isSaving = false;
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
              decoration: TextDecoration.underline,
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
            ),
            SizedBox(height: 28.h),
            TextFormField(
              enabled: false,
              onTap: () async {
                ImagePicker picker = ImagePicker();
                XFile? pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
              },
              decoration: InputDecoration(
                hintText: "Enter category name",
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
            ),
          ],
        )),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () async {
              setState(() {
                isSaving = true;
              });
              try {
                await Future.delayed(
                  const Duration(seconds: 2),
                );

                setState(() {
                  isSaving = false;
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
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Add Product Category"),
          ),
        ),
      ),
    );
  }
}
