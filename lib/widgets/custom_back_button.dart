import "package:flutter/material.dart";
import "package:zaccount/utils/constants.dart";

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required double deviceHeight,
    required this.icon,
    this.onTap,
  }) : _deviceHeight = deviceHeight;

  final double _deviceHeight;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _deviceHeight * 0.046,
        height: _deviceHeight * 0.046,
        decoration: BoxDecoration(
          color: primary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Container(
            width: _deviceHeight * 0.027,
            height: _deviceHeight * 0.027,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
