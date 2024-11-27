import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/models/store.dart';
import 'package:zaccount/presentation/providers/role_provider.dart';
import 'package:zaccount/presentation/providers/staff_provider.dart';
import 'package:zaccount/screens/store_management.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class AddStaffFormScreenTwo extends ConsumerStatefulWidget {
  const AddStaffFormScreenTwo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStaffFormScreenTwoState();
}

class _AddStaffFormScreenTwoState extends ConsumerState<AddStaffFormScreenTwo> {
  GlobalKey formKey = GlobalKey();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController accessController = TextEditingController();
  bool isButtonEnabled = false;
  bool isModalOpen = false;
  Map<String, dynamic> store = {};

  void _checkIfAllFieldsFilled() {
    bool allFieldsFilled = departmentController.text.isNotEmpty &&
        roleController.text.isNotEmpty &&
        storeController.text.isNotEmpty &&
        accessController.text.isNotEmpty;

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
                  controller: departmentController,
                  icon: CupertinoIcons.briefcase,
                  hintText: "Enter department name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  controller: roleController,
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
                    Store result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) =>
                            const StoreManagementScreen(isClickabe: true),
                      ),
                    );
                    setState(() {
                      store = result as Map<String, dynamic>;
                      storeController.text = result.name;
                    });
                  },
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  readOnly: true,
                  controller: accessController,
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
                    final staffRole = await showModalBottomSheet(
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
                            final asyncvalue = ref.watch(roleStremProvider);
                            return SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Select staff access level",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  asyncvalue.when(
                                    data: (data) {
                                      final roles = data;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          children: [
                                            ...roles.map(
                                              (role) => GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  Navigator.pop(
                                                      context, role.roleName);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Text(role.roleName),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    error: (error, stackTrace) =>
                                        Text(error.toString()),
                                    loading: () =>
                                        const CupertinoActivityIndicator(),
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
                      accessController.text = staffRole;
                    });

                    ref.read(staffProvider.notifier).updateAdditionalInfo(
                          department: departmentController.text,
                          roleName: roleController.text,
                          storeId: store['id'],
                          storeName: store['name'],
                          access: accessController.text,
                          storeLocation: store['location'],
                        );
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
