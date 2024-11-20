import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:zaccount/utils/constants.dart";

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required double deviceWidth,
    required double deviceHeight,
    required this.title,
    required this.onTap,
  })  : _deviceWidth = deviceWidth,
        _deviceHeight = deviceHeight;

  final double _deviceWidth;
  final double _deviceHeight;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.007),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).primaryColor,
        child: Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
