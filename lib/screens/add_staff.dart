import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/presentation/providers/staff_provider.dart';
import 'package:zaccount/screens/add_staff_two.dart';
import 'package:zaccount/shared/widgets/input_form_field.dart';

class AddStaffFormScreen extends ConsumerStatefulWidget {
  const AddStaffFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStaffFormScreenState();
}

class _AddStaffFormScreenState extends ConsumerState<AddStaffFormScreen> {
  GlobalKey formKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    RegExp emailregx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$');
    bool allFieldsFilled = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        emailregx.hasMatch(emailController.text) &&
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
                  icon: CupertinoIcons.person,
                  hintText: "Enter first name",
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  controller: lastNameController,
                  icon: CupertinoIcons.person,
                  hintText: "Enter last name",
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  controller: emailController,
                  icon: CupertinoIcons.envelope,
                  hintText: "Enter email",
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                ),
                SizedBox(height: 24.h),
                InputFormField(
                  controller: phoneController,
                  icon: CupertinoIcons.phone,
                  hintText: "0xxx-xxx-xxx",
                  inputFormatters: [
                    MaskedInputFormatter("0###-###-###"),
                  ],
                  onChanged: (text) => _checkIfAllFieldsFilled(),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 32.h),
                const Row(
                  children: [
                    Icon(
                      CupertinoIcons.checkmark_shield_fill,
                      color: Colors.green,
                    ),
                    SizedBox(width: 12),
                    Text("Your indormation is protected"),
                  ],
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      isButtonEnabled
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade700,
                    ),
                    minimumSize: const WidgetStatePropertyAll(
                      Size(double.infinity, 44),
                    ),
                    shape: WidgetStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          ref.read(staffProvider.notifier).updatePersonalInfo(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const AddStaffFormScreenTwo(),
                            ),
                          );
                        }
                      : null,
                  child: const Text(
                    'Continue',
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
