import "package:flutter/material.dart";
import "package:zaccount/screens/copy.dart";

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isTopVisible = false;
  bool _isBottomVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _nextPage() {
    setState(() {
      // Hide both sections before moving to the next page
      _isTopVisible = false;
      _isBottomVisible = false;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (_currentPage < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.of(context).push(_createRoute());
      }
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _isTopVisible = false;
      _isBottomVisible = false;
    });

    // Delay to smoothly animate between page changes
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _currentPage = page;
        _isTopVisible = true;
        _isBottomVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView for onboarding pages
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildOnboardingPage(
                image:
                    'https://img.freepik.com/free-vector/flat-people-business-training-illustration_23-2148922530.jpg?semt=ais_hybrid',
                title: 'Welcome to Our App',
                description: 'Explore the amazing features we offer.',
              ),
              _buildOnboardingPage(
                image: 'assets/onboarding_image2.png',
                title: 'Stay Connected',
                description: 'Stay in touch with your team anytime, anywhere.',
              ),
              _buildOnboardingPage(
                image: 'assets/onboarding_image3.png',
                title: 'Achieve Your Goals',
                description:
                    'Track your progress and reach your targets easily.',
              ),
            ],
          ),
          // Bottom Section: Indicator and Next button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            bottom: _isBottomVisible ? 100 : -500,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(_currentPage == 2 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build onboarding page layout
  Widget _buildOnboardingPage(
      {required String image,
      required String title,
      required String description}) {
    return Stack(
      children: [
        // Top Section: Image and Text
        AnimatedPositioned(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          top: _isTopVisible ? 100 : -500, // Slide down animation
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(image, height: 300),
              const SizedBox(height: 20),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page transition to LoginScreen
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
