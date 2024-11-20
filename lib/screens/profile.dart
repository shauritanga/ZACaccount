import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _genderController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _regionController;
  late final TextEditingController _zipController;
  late final TextEditingController _unitController;
  late final TextEditingController _roleController;
  late final TextEditingController _departmentController;

  bool isSaving = false;
  late double _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    final company = ref.read(companyProvider);
    _firstNameController =
        TextEditingController(text: company.individual?.firstName);
    _lastNameController =
        TextEditingController(text: company.individual?.lastName);
    _emailController = TextEditingController(text: company.individual?.email);
    _phoneController = TextEditingController(text: company.individual?.phone);
    _streetController =
        TextEditingController(text: company.individual?.address?.street);
    _cityController =
        TextEditingController(text: company.individual?.address?.city);
    _regionController =
        TextEditingController(text: company.individual?.address?.country);
    _zipController =
        TextEditingController(text: company.individual?.address?.zipCode);
    _unitController =
        TextEditingController(text: company.individual?.address?.unitNumber);
    _departmentController = TextEditingController(text: "");
    _roleController = TextEditingController(text: "");
    _genderController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Personal Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: "Role",
                  hintText: "Enter role",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(
                  labelText: "Department",
                  hintText: "Enetr Department",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(
                  labelText: "Gender",
                  hintText: "Enter Gender",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: "Street Name",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _unitController,
                decoration: InputDecoration(
                  labelText: "Unit Number",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "City",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _regionController,
                decoration: InputDecoration(
                  labelText: "Region",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              TextFormField(
                controller: _zipController,
                decoration: InputDecoration(
                  labelText: "ZipCode",
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "Change Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: const Text("Send password reset link to link email"),
                trailing: const Icon(
                  (CupertinoIcons.envelope),
                ),
                onTap: () {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) return;
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: user.email!);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          onPressed: () async {},
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: isSaving
              ? const CupertinoActivityIndicator(color: Colors.white)
              : const Text("Add Customer"),
        ),
      ),
    );
  }
}
