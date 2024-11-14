import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomTile extends StatefulWidget {
  const CustomTile({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.onTap,
  });
  final String title;
  final Color? color;
  final void Function()? onTap;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style:
                  TextStyle(color: widget.color, fontWeight: FontWeight.w600),
            ),
            Icon(
              HugeIcons.strokeRoundedTick02,
              color: widget.color,
            )
          ],
        ),
      ),
    );
  }
}
