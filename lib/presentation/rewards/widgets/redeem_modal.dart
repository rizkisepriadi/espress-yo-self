import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/common/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RedeemModal extends ConsumerStatefulWidget {
  final int points;
  final int filledCups;

  const RedeemModal({
    super.key,
    required this.points,
    required this.filledCups,
  });

  @override
  ConsumerState<RedeemModal> createState() => _RedeemModalState();
}

class _RedeemModalState extends ConsumerState<RedeemModal> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final rewards = ref.watch(activeRewardsProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: colorScheme.outline.withAlpha(113),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Redeem Rewards',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.stars,
                  color: colorScheme.onPrimaryContainer,
                  size: 25.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Available Points: ${widget.points}',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Divider(height: 1.h),
          Expanded(
            child: rewards.when(
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              error: (error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error loading rewards: $error'),
                      ElevatedButton(
                        onPressed: () => ref.refresh(activeRewardsProvider),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
              data: (rewardsList) {
                if (rewardsList.isEmpty) {
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Icon(
                          Icons.card_giftcard,
                          size: 48.sp,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No rewards available',
                          style: textTheme.bodyLarge,
                        ),
                      ]));
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: rewardsList.length,
                  itemBuilder: (context, index) {
                    final reward = rewardsList[index];
                    return CouponCard(
                      title: reward.name,
                      onPressed: () {
                        // Handle reward redemption logic here
                      },
                      description: reward.description,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
