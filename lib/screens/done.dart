import 'package:flutter/material.dart';
import 'package:zaccount/screens/home.dart';
import 'package:zaccount/tria.dart';

class FullScreenLoader extends StatefulWidget {
  const FullScreenLoader({super.key});

  @override
  _FullScreenLoaderState createState() => _FullScreenLoaderState();
}

class _FullScreenLoaderState extends State<FullScreenLoader> {
  @override
  void initState() {
    super.initState();
    // Start the saving operation when the screen is displayed
    saveData();
  }

  // Simulate data saving
  Future<void> saveData() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate a delay

    // After saving is complete, navigate back to the previous screen
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
