import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 102.w,
      height: 102.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4.h),
            )
          ]),
      padding: EdgeInsets.all(12.w),
      child: FloatingActionButton(
        onPressed: () {
          context.push('/qr');
        },
        elevation: 0,
        backgroundColor: colorScheme.onSurface,
        shape: CircleBorder(),
        child: Icon(
          Icons.qr_code_scanner,
          size: 36.w,
          color: Colors.white,
        ),
      ),
    );
  }
}
