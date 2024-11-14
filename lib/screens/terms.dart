import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/utils/constants.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 12,
            leading: const SizedBox(),
            pinned: true,
            floating: true,
            expandedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1.0,
              title: Text(
                "Terms of services",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Last Updated:February 11,2023",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "1. Acceptance of Terms",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "At ZAccount, we are dedicated to protecting the privacy and confidentiality of our users' information. This privacy Policy outlines how we collect, use, share and safeguard the data you provide to us through our accounting and invoice management app.",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "2. Use of our App",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "When you use ZACcount, we collect various types of information to provide you with our services effectively. This may include personal details such as your name, email address, phone number, and transactin history. We utilize this information to facilitate the core functionalities of our app, including tracking layaway payments, managing invoices, and sending notifications regarding payment deadlines. Additionally, we may analyze this data to enhance our services, communicate with you about updates or improvements, and ensure compliance with legal obligations.",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "3. Intellectual Property Rights",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    " We may share your information with third parties in the following circumstances:",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "4. User Content",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "ZACcount employs industry-standard security measures to protect your information from unauthorized access, misuse, alteration, or destruction. These measures include encccryption,access controls, and regular security audits. However, please note that no method of transmission over the internet or electronic storage is entirely secure, and cannot guarantee absolute security",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "5. Prohibited Conduct",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "You have the right to access, correct, or delete the personal information we hold about you. You may also choose to restrict the processing of your data or opt-out of certain communications. We provide tools and settings within the app to faccilitate these actions, and you can also contact us directly for assistance",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "6. Diclaimer of Warranties",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "We reserve the right to update this privacy Policy periodically to reflect changes in our practices or legal requirements. we will notify you of any significant changes and provide you with the opportunity to review and consent to thse updates where required by applicable laws",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "7. Limitation of Liability",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "We reserve the right to update this privacy Policy periodically to reflect changes in our practices or legal requirements. we will notify you of any significant changes and provide you with the opportunity to review and consent to thse updates where required by applicable laws",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "8. Governing Law and Disputes Resolution",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "We reserve the right to update this privacy Policy periodically to reflect changes in our practices or legal requirements. we will notify you of any significant changes and provide you with the opportunity to review and consent to thse updates where required by applicable laws",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "9. Changes to Terms and Conditions",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "We reserve the right to update this privacy Policy periodically to reflect changes in our practices or legal requirements. we will notify you of any significant changes and provide you with the opportunity to review and consent to thse updates where required by applicable laws",
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "10. Contact Us",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      text: "",
                      style: GoogleFonts.roboto(color: Colors.black87),
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              "If you have any questions, concerns about these Terms and Conditions, please contact us at ",
                        ),
                        TextSpan(
                          text: " privacy@zaccount.com",
                          style: GoogleFonts.roboto(color: primary),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ],
      ),
    );
  }
}
