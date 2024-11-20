import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:zaccount/utils/gamil_sign_in.dart';

Future<void> sendEmailWithPdf(File pdfFile) async {
  UserCredential userCredential = await signInWithGoogle();
  User? user = userCredential.user;

  if (user == null) return;

  final token = userCredential.credential?.accessToken;

  // Define the SMTP server (e.g., for Gmail)
  final smtpServer = gmailSaslXoauth2(user.email.toString(), token.toString());

  // Create the email message
  final message = Message()
    ..from = Address(user.email.toString(), 'ZACcount')
    ..recipients.add('curtisisaac36@gmail.com') // Add recipient(s)
    ..subject = 'Your PDF Attachment'
    ..text = 'Please find the PDF attached.'
    ..attachments.add(FileAttachment(pdfFile,
        contentType: "application/pdf", fileName: pdfFile.path));

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('Message not sent. ${e.toString()}');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
