import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required isAppBarExpanded,
    required this.title,
    required this.icon,
    this.onTap,
  }) : _isAppBarExpanded = isAppBarExpanded;

  final bool _isAppBarExpanded;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_isAppBarExpanded ? 7 : 17.5),
            ),
            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),
          _isAppBarExpanded ? const SizedBox(height: 4) : Container(),
          _isAppBarExpanded
              ? Text(
                  title,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                )
              : Container(),
        ],
      ),
    );
  }
}
