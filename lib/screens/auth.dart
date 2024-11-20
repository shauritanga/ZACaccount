import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/screens/login.dart';

class AuthStateTracker extends ConsumerWidget {
  const AuthStateTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator while checking the auth state
        }
        // Check if a user is logged in
        if (snapshot.hasData) {
          //Get user data
          ref.watch(companyProvider.notifier).fetchData();

          return const HomeScreen();
        } else {
          // User is not logged in (logged out)
          return const LoginScreen();
        }
      },
    );
  }
}

class FirstTimeScreen extends StatelessWidget {
  const FirstTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: const Center(
        child: Text('Welcome! This is your first time using the app.'),
      ),
    );
  }
}
