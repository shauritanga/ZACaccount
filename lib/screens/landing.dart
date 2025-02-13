import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/screens/first.dart';
import 'package:zaccount/screens/login.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _handlePageChange(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        onPageChanged: _handlePageChange,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FirstLandingScreen(
            onPressed: () {
              _updateCurrentPageIndex(_currentPageIndex + 1);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                        imageUrl:
                            "https://img.freepik.com/premium-vector/man-is-giving-presentation-group-people_1134986-16313.jpg?semt=ais_hybrid"),
                    Positioned(
                      top: kToolbarHeight,
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          _updateCurrentPageIndex(0);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  "Simplify",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Your finances",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Discover how ZACcount can help you simplify tasks and stay organized",
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          Theme.of(context).primaryColor),
                      minimumSize:
                          WidgetStatePropertyAll<Size>(Size(200.w, 50.h)),
                    ),
                    child: const Text(
                      "NEXT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
