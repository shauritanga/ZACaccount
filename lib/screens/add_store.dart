import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/presentation/providers/store_provider.dart';
import 'package:zaccount/screens/add_store_address.dart';
import 'package:zaccount/widgets/input_form_field.dart';

class AddStoreFormScreen extends ConsumerStatefulWidget {
  const AddStoreFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStoreFormScreenState();
}

class _AddStoreFormScreenState extends ConsumerState<AddStoreFormScreen> {
  GlobalKey formKey = GlobalKey();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isButtonEnabled = false;

  void _checkIfAllFieldsFilled() {
    RegExp emailregx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$');
    bool allFieldsFilled = storeNameController.text.isNotEmpty &&
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
                  controller: storeNameController,
                  icon: CupertinoIcons.cube_box,
                  hintText: "Enter store name",
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
                          ref
                              .read(storeProvider.notifier)
                              .updateStoreInformation(
                                  name: storeNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const AddStoreAddressForm(),
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
