import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/shared/widgets/custom_search_box.dart';

// ignore: must_be_immutable
class CustomerHeaderWithSearchAndTab extends ConsumerStatefulWidget {
  CustomerHeaderWithSearchAndTab(
      {super.key,
      required this.title,
      required this.widgetToNavigate,
      this.onTap,
      required this.menu});
  int selectedTabIndex = 0;
  final String title;

  final Widget widgetToNavigate;
  final void Function()? onTap;
  AsyncValue menu;

  @override
  ConsumerState<CustomerHeaderWithSearchAndTab> createState() =>
      _CustomerHeaderWithSearchAndTabState();
}

class _CustomerHeaderWithSearchAndTabState
    extends ConsumerState<CustomerHeaderWithSearchAndTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 18.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (ctx) {
                              return widget.widgetToNavigate;
                            }),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomSearchBox(
                searchTitle: "Search...",
                deviceWidth: MediaQuery.sizeOf(context).width,
              ),
            ),
            SizedBox(height: 22.h),
            widget.menu.when(
              data: (data) {
                final menu = data;
                return SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menu.length + 1,
                    itemBuilder: (context, index) {
                      if (index == menu.length) {
                        return GestureDetector(
                          onTap: widget.onTap,
                          child: const Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                            applyTextScaling: true,
                            weight: 900,
                          ),
                        );
                      }
                      final item = menu[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedTabIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: widget.selectedTabIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              item.name,
                              style: GoogleFonts.roboto(
                                color: widget.selectedTabIndex == index
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) => Text(
                error.toString(),
              ),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
