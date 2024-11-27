import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/models/auth_data.dart';
import 'package:zaccount/models/company.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/screens/privacy.dart';
import 'package:zaccount/screens/signup.dart';
import 'package:zaccount/screens/terms.dart';
import 'package:zaccount/screens/welcome.dart';
import 'package:zaccount/utils/alert_user.dart';
import 'package:zaccount/utils/constants.dart';
import 'package:zaccount/utils/gmail_sign_in.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSaving = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 32.h,
                  width: 32.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.chevron_left, color: Colors.blue.shade900),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/zaclogo.png",
                  height: 150.h,
                ),
              ),
              SizedBox(height: 34.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Let's",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40.sp,
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
                    fontSize: 40.sp,
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
              const SizedBox(height: 32),
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
                            HugeIcons.strokeRoundedMail02,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: lightGrey,
                          hintText: "Enter email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onSaved: (value) => email = value!,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            HugeIcons.strokeRoundedLockPassword,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: lightGrey,
                          hintText: "Enter password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7.r),
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
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const SignUpScreen(),
                        ),
                      );
                    },
                    label: Text(
                      "Create Account",
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
              SizedBox(height: 18.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      isSaving = true;
                    });
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();

                      try {
                        UserCredential credential =
                            await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        setState(() {
                          isSaving = false;
                        });
                        User? user = credential.user;
                        if (!user!.emailVerified) {
                          await user.sendEmailVerification();
                          if (!context.mounted) return;
                          await alertUserVerification(context);
                          return;
                        }
                        AuthDataResultModel(uid: user.uid, email: user.email);
                        Company? company = await ref
                            .watch(companyProvider.notifier)
                            .fetchData();

                        // After saving is complete, navigate back to the previous screen
                        print(company);
                        if (company == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                          return;
                        }

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const HomeScreen()),
                            (ctx) => false);
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isSaving = false;
                        });

                        if (e.code == "invalid-credential") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              content: Text("Invalid email or password"),
                            ),
                          );
                        }
                      }
                    }
                    setState(() {
                      isSaving = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: isSaving
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: InkWell(
                  onTap: () async {
                    try {
                      UserCredential? userCredential = await signInWithGoogle();
                      final res =
                          await ref.read(companyProvider.notifier).fetchData();
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
                    } on FirebaseAuthException catch (e) {
                      
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF397AF3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google_logo.png",
                          width: 20.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Continue with Google',
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
