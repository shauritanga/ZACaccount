import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hugeicons/hugeicons.dart";

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({
    super.key,
    required double deviceWidth,
    this.onChanged,
    this.controller,
  }) : _deviceWidth = deviceWidth;

  final double _deviceWidth;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 2, 33, 80).withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      width: _deviceWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            HugeIcons.strokeRoundedSearch01,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(width: _deviceWidth * 0.02),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white, // Set the color of the text
                fontSize: 18.0, // Optional: set the font size
              ),
              controller: controller,
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
