import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyIconComponent extends StatelessWidget {
  final void Function()? onTap;
  final IconData iconData;
  final String text;

  const MyIconComponent({
    super.key,
    this.onTap,
    this.iconData = Icons.notifications,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 30,  // set to 40 as you want
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: const Color(0xFFFF4548),
              size: 18, // smaller icon size to fit
            ),
            SizedBox(height: 4),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10, // reasonable font size to fit in 40 height
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

  }
}
