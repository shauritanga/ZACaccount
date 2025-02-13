import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/screens/login.dart';
import 'package:zaccount/screens/privacy.dart';
import 'package:zaccount/screens/terms.dart';
import 'package:zaccount/screens/welcome.dart';
import 'package:zaccount/utils/alert_user.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
        final res = await ref.read(companyProvider.notifier).fetchData();
        if (res == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const WelcomeScreen(),
            ),
          );
          return;
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (ctx) => const HomeScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/zaclogo.png",
                  height: 100.h,
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Let's",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Get started",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Text(
                  "To begin using ZACcount, create an account and start managing your finaces with ease",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        // height: 50.h,
                        child: TextFormField(
                          cursorHeight: 15.sp,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(
                              CupertinoIcons.person,
                              color: Colors.grey,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText: "First Name",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                          onSaved: (value) => firstName = value!,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        // height: 50.h,
                        child: TextFormField(
                          cursorHeight: 15.h,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(
                              CupertinoIcons.person,
                              color: Colors.grey,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText: "Last Name",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                          onSaved: (value) => lastName = value!,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Last name is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        // height: 50.h,
                        child: TextFormField(
                          cursorHeight: 15.sp,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(
                              CupertinoIcons.envelope,
                              color: Colors.grey,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText: "Email Address",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          onSaved: (value) => email = value!,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            RegExp emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            bool isValid = emailRegex.hasMatch(value!);
                            if (value.isEmpty) {
                              return "Email name is required";
                            }
                            if (!isValid) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        // height: 50.h,
                        child: TextFormField(
                          cursorHeight: 15.sp,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(
                              HugeIcons.strokeRoundedLockPassword,
                              color: Colors.grey,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText: "Password",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          obscureText: true,
                          onSaved: (value) => password = value!,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        // height: 50.h,
                        child: TextFormField(
                          cursorHeight: 15.sp,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(
                              HugeIcons.strokeRoundedLockPassword,
                              color: Colors.grey,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText: "Confirm Password",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                          obscureText: true,
                          onSaved: (value) => confirmPassword = value!,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
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
                    label: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    icon: Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      color: Theme.of(context).primaryColor,
                      size: 18.sp,
                    ),
                    iconAlignment: IconAlignment.end,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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

                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

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
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          _isSaving = false;
                        });
                        if (e.code == "email-already-in-use") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              content: Text(
                                  "Email already in use with another account"),
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50.h),
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
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 12.sp),
                      )),
                  Text(
                    "&",
                    style: TextStyle(fontSize: 12.sp),
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
                      child: Text(
                        "Terms of Use",
                        style: TextStyle(fontSize: 12.sp),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
