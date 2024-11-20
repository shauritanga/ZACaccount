import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/screens/welcome.dart';
import 'package:zaccount/tria.dart';

import '../models/company.dart';

class FullScreenLoader extends ConsumerStatefulWidget {
  const FullScreenLoader({super.key});

  @override
  ConsumerState createState() => _FullScreenLoaderState();
}

class _FullScreenLoaderState extends ConsumerState<FullScreenLoader> {
  @override
  void initState() {
    super.initState();

    saveData();
  }

  // Simulate data saving
  Future<void> saveData() async {
    Company? company = await ref.watch(companyProvider.notifier).fetchData();

    // After saving is complete, navigate back to the previous screen
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
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        (ctx) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Dim background
      body: Center(
        child: CircleAnimation(), // Show progress indicator
      ),
    );
  }
}
