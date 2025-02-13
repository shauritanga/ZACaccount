import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hugeicons/hugeicons.dart";

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({
    super.key,
    required double deviceWidth,
    this.onChanged,
    this.controller,
    required this.searchTitle,
  }) : _deviceWidth = deviceWidth;

  final double _deviceWidth;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String searchTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      width: _deviceWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            HugeIcons.strokeRoundedSearch01,
            color: Colors.white,
            size: 14.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white, // Set the color of the text
                fontSize: 14.0, // Optional: set the font size
              ),
              controller: controller,
              cursorHeight: 14.sp,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle:
                    GoogleFonts.roboto(color: Colors.white.withOpacity(0.4)),
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
