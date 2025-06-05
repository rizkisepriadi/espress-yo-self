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
  bool _isRedeeming = false;

  // Show confirmation dialog before redemption
  Future<void> _showRedeemConfirmation(
    BuildContext context,
    reward,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) async {
    final canAfford = reward.pointsRequired != null &&
        widget.points >= reward.pointsRequired!;

    if (!canAfford) {
      _showNotEnoughPointsDialog(reward, colorScheme, textTheme);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.card_giftcard, color: colorScheme.primary),
            SizedBox(width: 8.w),
            Text('Confirm Redemption', style: textTheme.headlineSmall),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to redeem this reward?',
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.name ?? 'Unknown Reward',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    reward.description ?? 'No description available',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.stars, size: 16.sp, color: Colors.orange),
                      SizedBox(width: 4.w),
                      Text(
                        '${reward.pointsRequired ?? 0} points',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(50),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, size: 16.sp, color: Colors.blue),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Points after redemption: ${widget.points - (reward.pointsRequired ?? 0)}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: textTheme.labelLarge),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
            ),
            child: Text(
              'Redeem',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _performRedemption(reward, colorScheme, textTheme);
    }
  }

  // Show not enough points dialog
  void _showNotEnoughPointsDialog(
    reward,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final neededPoints = (reward.pointsRequired ?? 0) - widget.points;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: colorScheme.error),
            SizedBox(width: 8.w),
            Text('Not Enough Points', style: textTheme.headlineSmall),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You need $neededPoints more points to redeem this reward.',
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.orange.withAlpha(50),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.stars, color: Colors.orange),
                  SizedBox(width: 8.w),
                  Text(
                    'Current: ${widget.points} | Need: ${reward.pointsRequired}',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Perform the actual redemption
  Future<void> _performRedemption(
    reward,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) async {
    setState(() {
      _isRedeeming = true;
    });

    try {
      final currentUser = await ref.read(currentUserProvider.future);
      final rewardRepository = ref.read(rewardRepositoryProvider);

      await rewardRepository.redeemReward(
        currentUser.id,
        reward.id,
        reward.pointsRequired ?? 0,
      );

      if (mounted) {
        _showSuccessDialog(reward, colorScheme, textTheme);
        ref.invalidate(currentUserProvider);
        ref.invalidate(activeRewardsProvider);
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString(), colorScheme, textTheme);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRedeeming = false;
        });
      }
    }
  }

  // Show success dialog
  void _showSuccessDialog(
    reward,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28.sp),
            SizedBox(width: 8.w),
            Text('Success!', style: textTheme.headlineSmall),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congratulations! You have successfully redeemed:',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(50),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.green.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Text(
                    reward.name ?? 'Unknown Reward',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stars, color: Colors.green, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${reward.pointsRequired} points used',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Check your "My Rewards" tab to view your redeemed rewards.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Future.delayed(Duration.zero, () {
                if (mounted) {
                  Navigator.of(context).pop();
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(double.infinity, 40.h),
            ),
            child: Text(
              'Awesome!',
              style: textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show error dialog
  void _showErrorDialog(
    String error,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8.w),
            Text('Redemption Failed', style: textTheme.headlineSmall),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sorry, we couldn\'t process your redemption.',
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(50),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                error,
                style: textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Please try again or contact support if the problem persists.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: textTheme.labelLarge),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final rewards = ref.watch(activeRewardsProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: colorScheme.outline.withAlpha(113),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
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

          // Points display
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
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Available Points: ${widget.points}',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),
          Divider(height: 1.h),

          // Loading overlay
          if (_isRedeeming)
            Expanded(
              child: Container(
                color: Colors.black.withAlpha(127),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text(
                          'Processing Redemption...',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Please wait while we process your reward',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            // Rewards list
            Expanded(
              child: rewards.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 48.sp, color: Colors.red),
                      SizedBox(height: 16.h),
                      Text(
                        'Error loading rewards',
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        error.toString(),
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () => ref.refresh(activeRewardsProvider),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (rewardsList) {
                  if (rewardsList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.card_giftcard,
                            size: 48.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No rewards available',
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: rewardsList.length,
                    itemBuilder: (context, index) {
                      final reward = rewardsList[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CouponCard(
                          title: reward.name,
                          pointsRequired: reward.pointsRequired,
                          userPoints: widget.points,
                          onPressed: () => _showRedeemConfirmation(
                            context,
                            reward,
                            colorScheme,
                            textTheme,
                          ),
                          description: reward.description,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
