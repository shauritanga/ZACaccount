import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSaving = false;
  late double _deviceHeight, _deviceWidth;
  Map<String, dynamic> person = {
    "First Name": "Athanas",
    "Lsst Name": "Shauritanga",
    "Email address": "shauritangaathanas@gmail.com",
    "Date of Birth": "21/06/1986",
    "Role": "",
    "Department": "",
    "Phone Number": "0629593331",
    "Gender": "Male",
    "Street Address": "Tangi bovu",
    "aptNumber": 45,
  };
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (String key in person.keys)
                TextFormField(
                  initialValue: '${person[key]}',
                  decoration: InputDecoration(
                    labelText: key,
                    hintText: key,
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              SizedBox(height: _deviceHeight * 0.05),
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
