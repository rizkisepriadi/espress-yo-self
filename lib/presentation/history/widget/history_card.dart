import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard(
      {super.key,
      required this.title,
      required this.timestamp,
      required this.pointsEarned,
      required this.imageUrl,
      this.amount});

  final String title;
  final String timestamp;
  final int pointsEarned;
  final String imageUrl;
  final double? amount;

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.primaryContainer, width: 2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.imageUrl, width: 120.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      Text('+ ${widget.pointsEarned} pts',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      Text(widget.timestamp, style: textTheme.titleSmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8.h,
            right: 8.w,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Detail',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: colorScheme.onSurface,
                    size: 22.sp,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
