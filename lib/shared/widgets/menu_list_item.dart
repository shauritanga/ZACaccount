import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuListItem extends ConsumerWidget {
  const MenuListItem({
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.color,
    super.key,
  });

  final IconData? leading;
  final String title;
  final Color? color;
  final IconData? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              leading,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: color ?? Theme.of(context).colorScheme.onSurface,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              trailing,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
