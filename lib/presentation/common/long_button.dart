import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LongButton extends StatefulWidget {
  const LongButton(
      {super.key, this.text, required this.press, this.image, this.color});
  final String? text;
  final VoidCallback press;
  final String? image;
  final Color? color;

  @override
  State<LongButton> createState() => _LongButtonState();
}

class _LongButtonState extends State<LongButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 360.w,
      height: 55.h,
      child: ElevatedButton(
        onPressed: widget.press,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color ?? colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shadowColor: colorScheme.shadow,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.image != null)
              SvgPicture.asset(
                widget.image!,
                height: 75.h,
                width: 24.w,
              ),
            if (widget.image != null && widget.text != null)
              SizedBox(width: 8.w),
            if (widget.text != null)
              Text(
                widget.text!,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
