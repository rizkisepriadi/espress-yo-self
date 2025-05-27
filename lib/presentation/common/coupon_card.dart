import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouponCard extends StatefulWidget {
  const CouponCard(
      {super.key, this.title, this.onPressed, this.icon, this.description});

  final String? title;
  final VoidCallback? onPressed;
  final Icon? icon;
  final String? description;

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
                  : SvgPicture.asset(
                      "assets/svgs/cup_coupon_icon.svg",
                      height: 112,
                      width: 111,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
