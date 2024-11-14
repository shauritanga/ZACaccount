import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaccount/widgets/custom_button.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({super.key});

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  final Map<String, dynamic> companyDetails = {
    "Company Name": "Dalali Inc",
    "Legal Name": "Dalali Company LTD",
    "Company Type": "Individual",
    "Email Address": "info@dalali.co.tz",
    "Phone Number": "0655591660",
    "Website": "www.dalali.co.tz",
    "Street Name": "Kibo Complex"
  };
  final ImagePicker _picker = ImagePicker();
  late double _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: _deviceHeight * 0.01),
              GestureDetector(
                onTap: () async {
                  debugPrint("tapped");
                  await _picker.pickImage(source: ImageSource.gallery);
                },
                child: Container(
                  height: _deviceHeight * 0.10,
                  width: _deviceWidth * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: const [8, 4],
                      strokeWidth: 2,
                      child: SizedBox(
                        width: _deviceWidth * 0.30,
                        height: _deviceHeight * 0.08,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.photo_fill,
                                size: 35,
                              ),
                              Text("Add logo")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: _deviceHeight * 0.02),
              for (String key in companyDetails.keys)
                TextFormField(
                  initialValue: companyDetails[key],
                  decoration: InputDecoration(labelText: key),
                ),
              SizedBox(height: _deviceHeight * 0.05),
              CustomButton(
                deviceWidth: _deviceWidth,
                deviceHeight: _deviceHeight,
                title: "Save Information",
              )
            ],
          ),
        ),
      ),
    );
  }
}
