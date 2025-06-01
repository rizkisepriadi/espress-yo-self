import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PointsCard extends StatefulWidget {
  final int points;
  final int filledCups;

  const PointsCard({super.key, required this.points, required this.filledCups});

  @override
  State<PointsCard> createState() => _PointsCardState();
}

class _PointsCardState extends State<PointsCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Points",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSecondary,
                ),
              ),
              Text(
                '${widget.points} pts',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(204),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coffees Stack",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
              _buildCoffeesStack(context, widget.filledCups),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 180.w,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("Details")),
            ),
            SizedBox(
              width: 180.w,
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("Redeem")),
            ),
          ],
        ),
      ],
    ));
  }
}

Widget _buildCoffeesStack(BuildContext context, int cups) {
  const int totalCups = 5;
  final int filledCups = cups;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              color: Colors.white.withAlpha(200),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalCups, (index) {
            return SizedBox(
              width: 56.w,
              child: Container(
                height: 56.w,
                width: 56.w,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Opacity(
                  opacity: index < filledCups ? 1.0 : 0.5,
                  child: SvgPicture.asset(
                    'assets/svgs/cup_icon.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}
