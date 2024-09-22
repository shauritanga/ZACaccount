import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 250,
                  width: double.infinity,
                ),
                Positioned(
                  top: kToolbarHeight,
                  left: 16,
                  child: Container(
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:
                        Icon(Icons.chevron_left, color: Colors.blue.shade900),
                  ),
                ),
                const SizedBox(
                  height: kToolbarHeight,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Let's",
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Get started",
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 40,
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
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                TextButton.icon(
                  onPressed: () {},
                  label: const Text("Create Account"),
                  icon: const Icon(HugeIcons.strokeRoundedCircleArrowRight02),
                  iconAlignment: IconAlignment.end,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll<Color?>(lightGrey),
                    foregroundColor: WidgetStatePropertyAll<Color?>(primary),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sign In"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/apple_logoo.png",
                        width: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Continue with Apple',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                        width: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  child: Text("Privacy Policy "),
                ),
                Text("&"),
                Container(
                  child: Text("Terms of Use"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
