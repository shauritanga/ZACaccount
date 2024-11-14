import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/screens/login.dart';
import 'package:zaccount/screens/privacy.dart';
import 'package:zaccount/screens/terms.dart';
import 'package:zaccount/utils/alert_user.dart';
import 'package:zaccount/utils/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  User? _user;
  late Stream<User?> _userChangesStream;

  @override
  void initState() {
    super.initState();
    _userChangesStream = _auth.userChanges();
    _userChangesStream.listen((user) async {
      _user = user;

      if (_user != null && _user!.emailVerified) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:
                          Icon(Icons.chevron_left, color: Colors.blue.shade900),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/zaclogo.png",
                height: 100,
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Let's",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Get started",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "To begin using ZACcount, create an account and start managing your finaces with ease",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(
                          CupertinoIcons.person,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: lightGrey,
                        hintText: "First Name",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onSaved: (value) => firstName = value!,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(
                          CupertinoIcons.person,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: lightGrey,
                        hintText: "Last Name",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onSaved: (value) => lastName = value!,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(
                          CupertinoIcons.envelope,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: lightGrey,
                        hintText: "Email Address",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onSaved: (value) => email = value!,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(
                          HugeIcons.strokeRoundedLockPassword,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: lightGrey,
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      obscureText: true,
                      onSaved: (value) => password = value!,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(
                          HugeIcons.strokeRoundedLockPassword,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: lightGrey,
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      obscureText: true,
                      onSaved: (value) => confirmPassword = value!,
                      keyboardType: TextInputType.visiblePassword,
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const LoginScreen(),
                      ),
                    );
                  },
                  label: const Text("Sign In"),
                  icon: Icon(
                    CupertinoIcons.arrow_right_circle_fill,
                    color: Theme.of(context).primaryColor,
                  ),
                  iconAlignment: IconAlignment.end,
                )
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState?.save();
                    if (password != confirmPassword) {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Password"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          content: const Text(
                              "Password entered do not seem to match, please make sure password are the same"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                      return;
                    }
                    setState(() {
                      _isSaving = true;
                    });
                    print("inafika");
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      print("inafika pia");
                      User? user = userCredential.user;
                      if (!user!.emailVerified) {
                        await user.sendEmailVerification();
                        setState(() {
                          _isSaving = false;
                        });
                        if (!context.mounted) return;
                        alertUserVerification(context);
                      }

                      setState(() {
                        _isSaving = false;
                      });
                    } catch (e) {
                      setState(() {
                        _isSaving = false;
                      });

                      print(e);
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).primaryColor,
                  ),
                  minimumSize: const WidgetStatePropertyAll(
                    Size(double.infinity, 44),
                  ),
                ),
                child: _isSaving
                    ? const CupertinoActivityIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("privacy policy tapped");
                      }
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        showDragHandle: true,
                        useSafeArea: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 1.0, //set this as you want
                            maxChildSize: 1.0, //set this as you want
                            minChildSize: 1.0, //set this as you want
                            expand: true,
                            builder: (context, scrollController) {
                              return const PrivacyPolicy(); //whatever you're returning, does not have to be a Container
                            },
                          );
                        },
                      );
                    },
                    child: const Text("privacy Policy")),
                const Text(
                  "&",
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        showDragHandle: true,
                        useSafeArea: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 1.0, //set this as you want
                            maxChildSize: 1.0, //set this as you want
                            minChildSize: 1.0, //set this as you want
                            expand: true,
                            builder: (context, scrollController) {
                              return const TermsOfUse(); //whatever you're returning, does not have to be a Container
                            },
                          );
                        },
                      );
                    },
                    child: const Text("Terms of Use")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
