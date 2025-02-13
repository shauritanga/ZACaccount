import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaccount/shared/widgets/input_field.dart';

class ProductTagForm extends StatefulWidget {
  const ProductTagForm({super.key});

  @override
  State<ProductTagForm> createState() => _ProductTagFormState();
}

class _ProductTagFormState extends State<ProductTagForm> {
  TextEditingController controller = TextEditingController(text: "");
  late Color background;
  bool isSaving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    background = Theme.of(context).primaryColor;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Tag"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomTextFormField(
          icon: const Icon(CupertinoIcons.tag),
          hintText: "Enter tag name",
          onChanged: (value) => controller.text = value,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () async {
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              Map<String, dynamic> data = {"name": controller.text};
              setState(() {
                isSaving = true;
              });
              DocumentReference reference =
                  await firestore.collection("product-tags").add(data);

              if (reference.id.isNotEmpty) {
                setState(() {
                  isSaving = false;
                  background = Colors.green;
                });
              } else {
                setState(() {
                  isSaving = false;
                  background = Colors.red;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: background,
              foregroundColor: Colors.white,
            ),
            child: isSaving
                ? const CupertinoActivityIndicator()
                : const Text("Add tag"),
          ),
        ),
      ),
    );
  }
}
