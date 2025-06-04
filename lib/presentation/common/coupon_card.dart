import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouponCard extends StatefulWidget {
  const CouponCard(
      {super.key,
      this.title,
      this.onPressed,
      this.icon,
      this.description,
      this.pointsRequired,
      this.userPoints});

  final String? title;
  final VoidCallback? onPressed;
  final Icon? icon;
  final String? description;
  final int? pointsRequired;
  final int? userPoints;

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 8.w),
        decoration: BoxDecoration(
            border: Border.all(color: colorScheme.onSurface.withAlpha(150)),
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title!,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    widget.description ?? '',
                    style: textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: widget.icon != null
                    ? widget.icon!
                    : Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/cup_coupon_icon.svg",
                            height: 112,
                            width: 111,
                          ),
                          if (widget.pointsRequired != null)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16.r)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.stars,
                                      color: colorScheme.onPrimaryContainer,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      widget.pointsRequired?.toString() ?? '0',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
