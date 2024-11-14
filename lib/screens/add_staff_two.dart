import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/screens/store_management.dart';
import 'package:zaccount/widgets/input_form_field.dart';

class AddStaffFormScreenTwo extends ConsumerStatefulWidget {
  const AddStaffFormScreenTwo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStaffFormScreenTwoState();
}

class _AddStaffFormScreenTwoState extends ConsumerState<AddStaffFormScreenTwo> {
  GlobalKey formKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isButtonEnabled = false;
  bool isModalOpen = false;

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        storeController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        phoneController.text.length == 12;

    if (allFieldsFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Add Staff"),
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
                  controller: firstNameController,
                  icon: CupertinoIcons.briefcase,
                  hintText: "Enter department name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  controller: lastNameController,
                  icon: CupertinoIcons.wrench,
                  hintText: "Enter role name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  readOnly: true,
                  controller: storeController,
                  icon: CupertinoIcons.cube,
                  hintText: "Select Store",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) =>
                            const StoreManagementScreen(isClickabe: true),
                      ),
                    );

                    setState(() {
                      storeController.text = result;
                    });
                  },
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  readOnly: true,
                  controller: phoneController,
                  icon: CupertinoIcons.lock_shield,
                  suffixIcon: Icon(
                    isModalOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  hintText: "Select access level",
                  onTap: () async {
                    setState(() {
                      isModalOpen = true;
                    });
                    await showModalBottomSheet(
                      showDragHandle: true,
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      builder: (ctx) {
                        return DraggableScrollableSheet(
                          maxChildSize: 0.5,
                          minChildSize: 0.2,
                          initialChildSize: 0.25,
                          snap: true,
                          expand: false,
                          builder: (context, scrollController) {
                            return const SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Select staff access level",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                    setState(() {
                      isModalOpen = false;
                    });
                  },
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const StoreManagementScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Save and Send Invite',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
