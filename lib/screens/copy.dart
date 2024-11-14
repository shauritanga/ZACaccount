import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _textVisible = false;

  @override
  void initState() {
    super.initState();
    // Delayed animation for welcome text
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _textVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background container for email, password and button
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      height: 100), // Spacer to make room for animated text
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Handle login button press
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),

          // Animated "Welcome onboard" text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _textVisible
                ? 530
                : -50, // Adjust the position based on visibility
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'Welcome onboard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
