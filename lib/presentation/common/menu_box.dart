import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuBox extends StatefulWidget {
  const MenuBox({super.key, this.title, this.points, this.image});

  final String? title;
  final int? points;
  final String? image;

  @override
  State<MenuBox> createState() => _MenuBoxState();
}

class _MenuBoxState extends State<MenuBox> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.center,
      width: 180.w,
      child: Column(
        children: [
          SvgPicture.asset(
            widget.image ?? "assets/svgs/menu_default.svg",
            height: 205.h,
            width: 205.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title!,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                '${widget.points} pts',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
