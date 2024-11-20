import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/shared/widgets/custom_button.dart';

class CompanyDetailsScreen extends ConsumerStatefulWidget {
  const CompanyDetailsScreen({super.key});

  @override
  ConsumerState<CompanyDetailsScreen> createState() =>
      _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends ConsumerState<CompanyDetailsScreen> {
  late final TextEditingController _companyNameController;
  late final TextEditingController _legalNameController;
  late final TextEditingController _companyTypeController;
  late final TextEditingController _tinController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _websiteController;
  late final TextEditingController _countryController;
  late final TextEditingController _streetController;
  late final TextEditingController _regionController;
  late final TextEditingController _cityController;
  late final TextEditingController _unitController;
  late final TextEditingController _zipController;
  final ImagePicker _picker = ImagePicker();
  late double _deviceHeight, _deviceWidth;

  @override
  void initState() {
    final company = ref.read(companyProvider);
    super.initState();
    _companyNameController =
        TextEditingController(text: company.businessProfile?.name);
    _legalNameController =
        TextEditingController(text: company.companyProfile?.name);
    _companyTypeController = TextEditingController(text: company.businessType);
    _tinController = TextEditingController(text: company.companyProfile?.taxId);
    _emailController = TextEditingController(text: company.email);
    _phoneController =
        TextEditingController(text: company.companyProfile?.phone);
    _websiteController =
        TextEditingController(text: company.businessProfile?.supportURL);
    _streetController =
        TextEditingController(text: company.companyProfile?.address.street);
    _countryController = TextEditingController(text: company.country);
    _regionController =
        TextEditingController(text: company.companyProfile?.address.country);
    _cityController =
        TextEditingController(text: company.companyProfile?.address.city);
    _unitController =
        TextEditingController(text: company.companyProfile?.address.unitNumber);
    _zipController =
        TextEditingController(text: company.companyProfile?.address.zipCode);
  }

  @override
  void dispose() {
    super.dispose();
    _companyNameController.dispose();
    _legalNameController.dispose();
    _companyTypeController.dispose();
    _tinController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _unitController.dispose();
    _zipController.dispose();
    _streetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Company Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () async {
                  debugPrint("tapped");
                  await _picker.pickImage(source: ImageSource.gallery);
                },
                child: Container(
                  height: _deviceHeight * 0.10,
                  width: _deviceWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: DottedBorder(
                      color: Colors.grey[400]!,
                      radius: const Radius.circular(5),
                      borderType: BorderType.RRect,
                      dashPattern: const [8, 4],
                      strokeWidth: 2,
                      child: SizedBox(
                        width: _deviceWidth * 0.30,
                        height: _deviceHeight * 0.08,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.photo_fill,
                                color: Colors.grey[600],
                                size: 35.sp,
                              ),
                              const Text("Add logo")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: "Company Name"),
              ),
              TextFormField(
                controller: _legalNameController,
                decoration: const InputDecoration(labelText: "Legal Name"),
              ),
              TextFormField(
                controller: _companyTypeController,
                decoration: const InputDecoration(labelText: "Company Type"),
              ),
              TextFormField(
                controller: _tinController,
                decoration:
                    const InputDecoration(labelText: "Registration Number"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email Address"),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(labelText: "website"),
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: "Street Name"),
              ),
              TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(labelText: "unit/apt Number"),
              ),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: "District"),
              ),
              TextField(
                controller: _regionController,
                decoration: const InputDecoration(labelText: "City"),
              ),
              TextField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: "Country"),
              ),
              TextField(
                controller: _zipController,
                decoration: const InputDecoration(labelText: "ZiCode"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: CustomButton(
            onTap: () async {
              try {
                await ref.read(companyProvider.notifier).updateCompanyDetails(
                      city: _cityController.text,
                      region: _regionController.text,
                      legalName: _legalNameController.text,
                      businessName: _companyNameController.text,
                      zipcode: _zipController.text,
                      country: _cityController.text,
                      street: _streetController.text,
                      unit: _unitController.text,
                      tin: _tinController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      website: _websiteController.text,
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Company details updated")));
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Company details update failed"),
                  ),
                );
              }
            },
            deviceWidth: _deviceWidth,
            deviceHeight: _deviceHeight,
            title: "Save Information",
          ),
        ),
      ),
    );
  }
}
