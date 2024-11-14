import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/presentation/providers/distric_provider.dart';
import 'package:zaccount/presentation/providers/store_provider.dart';
import 'package:zaccount/screens/districts.dart';
import 'package:zaccount/screens/regions.dart';
import 'package:zaccount/screens/store_success.dart';
import 'package:zaccount/widgets/input_form_field.dart';

class AddStoreAddressForm extends ConsumerStatefulWidget {
  const AddStoreAddressForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStoreAddressFormState();
}

class _AddStoreAddressFormState extends ConsumerState<AddStoreAddressForm> {
  GlobalKey formKey = GlobalKey();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  String selectedDistrict = "";
  String selectedRegion = "";
  bool isModalOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Add Store"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 24.h),
                InputFormField(
                  controller: streetController,
                  icon: CupertinoIcons.map,
                  hintText: "Enter line 1 eg Chole Rd",
                  hintStyle: const TextStyle(color: Colors.grey),
                  onChanged: (text) {
                    setState(() {
                      streetController.text = text;
                    });
                  },
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  controller: unitController,
                  icon: CupertinoIcons.map_pin_ellipse,
                  hintText: "Enter unit/apt number",
                  hintStyle: const TextStyle(color: Colors.grey),
                  onChanged: (text) {
                    setState(() {
                      unitController.text = text;
                    });
                  },
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  readOnly: true,
                  controller: districtController,
                  icon: CupertinoIcons.building_2_fill,
                  hintText: "Select District",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      useSafeArea: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      builder: (ctx) {
                        return DraggableScrollableSheet(
                          maxChildSize: 1.0,
                          minChildSize: 1.0,
                          initialChildSize: 1.0,
                          snap: true,
                          builder: (context, scrollController) {
                            return DistrictsScreen(
                                selected: districtController.text);
                          },
                        );
                      },
                    );
                    setState(() {
                      districtController.text = result?.district ?? "";
                      regionController.text = result?.region ?? "";
                    });
                    ref.read(searchQueryProvider.notifier).state = "";
                  },
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  readOnly: true,
                  controller: regionController,
                  icon: CupertinoIcons.flag,
                  suffixIcon: Icon(
                    isModalOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  hintText: "Select Region",
                  onTap: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      useSafeArea: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      builder: (ctx) {
                        return DraggableScrollableSheet(
                          maxChildSize: 1.0,
                          minChildSize: 1.0,
                          initialChildSize: 1.0,
                          snap: true,
                          builder: (context, scrollController) {
                            return RegionsScreen(
                                selected: regionController.text);
                          },
                        );
                      },
                    );
                    ref.read(searchQueryProvider.notifier).state = "";
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
              minimumSize: const WidgetStatePropertyAll(
                Size(double.infinity, 44),
              ),
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            onPressed: () async {
              ref.read(storeProvider.notifier).updateAddress(
                    street: streetController.text,
                    unitNumber: unitController.text,
                    city: districtController.text,
                    country: regionController.text,
                  );
              final result = await ref.read(storeProvider.notifier).addStore();
              if (result.isEmpty) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed, try again")),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => const StoreSuccessScreen(),
                ),
              );
            },
            child: const Text(
              'Save data',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
