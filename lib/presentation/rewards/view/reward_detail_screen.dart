import 'dart:async';
import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RewardDetailScreen extends ConsumerStatefulWidget {
  final String rewardId;

  const RewardDetailScreen({super.key, required this.rewardId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardDetailScreenState();
}

class _RewardDetailScreenState extends ConsumerState<RewardDetailScreen>
    with WidgetsBindingObserver {
  Timer? _countdownTimer;
  String _countdownText = '';
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(rewardDetailViewModelProvider.notifier)
          .fetchRewardRedemptionById(widget.rewardId);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // ← Remove observer
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      final rewardState = ref.read(rewardDetailViewModelProvider);
      rewardState.whenData((redemptions) {
        if (redemptions.isNotEmpty) {
          final redemption = redemptions.first;
          if (redemption is UserRedemptionEntity &&
              redemption.expiryDate != null) {
            startCountdown(redemption.expiryDate!);
          }
        }
      });
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _countdownTimer?.cancel();
    }
  }

  void startCountdown(DateTime expiryDate) {
    _countdownTimer?.cancel();

    updateCountdown(expiryDate);

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateCountdown(expiryDate);
      if (_isExpired) {
        timer.cancel();
      }
    });
  }

  void updateCountdown(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now);

    if (difference.isNegative) {
      setState(() {
        _countdownText = 'Expired';
        _isExpired = true;
      });
    } else {
      setState(() {
        _countdownText = formatDuration(difference);
        _isExpired = false;
      });
    }
  }

  String formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m ${seconds}s';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final rewardState = ref.watch(rewardDetailViewModelProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left,
              color: colorScheme.onSurface, size: 35.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Detail Coupon",
          style: textTheme.headlineSmall,
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(
          16.w,
        ),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            _showQRCodeDialog(context);
          },
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 8,
          icon: Icon(Icons.qr_code, size: 20.w),
          label: Text(
            "Show QR Code",
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset("assets/svgs/coupon_banner.svg"),
              SizedBox(
                width: double.infinity,
                child: rewardState.when(
                  data: (redemptions) {
                    if (redemptions.isEmpty) {
                      return const Center(
                        child: Text('Reward not found'),
                      );
                    }

                    final redemption = redemptions.first;
                    if (redemption is! UserRedemptionEntity) {
                      return const Center(
                        child: Text('Invalid data type received'),
                      );
                    }

                    if (redemption.expiryDate != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        startCountdown(redemption.expiryDate!);
                      });
                    }

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(redemption.rewardName,
                                    style: textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          size: 20.w,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "Expire In:",
                                          style: textTheme.bodyLarge,
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                          color: colorScheme.error,
                                          borderRadius:
                                              BorderRadius.circular(16.r)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            color: colorScheme.onError,
                                            size: 18.w,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            _countdownText,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: colorScheme.onError),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Divider(
                            color: Colors.black38,
                            thickness: 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(redemption.rewardDescription),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text(
                                    "TERMS & CONDITIONS",
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  """1. REDEMPTION
• Points will be deducted immediately upon redemption
• Redemptions cannot be cancelled or refunded
• Each redemption generates a unique QR code

2. VALIDITY
• Coupons are valid for 7 days from redemption date
• Expired coupons cannot be used
• One-time use only per coupon

3. USAGE
• Present QR code to authorized staff for validation
• Valid only at designated locations
• Cannot be transferred to other users

4. IMPORTANT
• Keep your QR code secure and private
• Report any issues within 24 hours
• Company reserves the right to cancel fraudulent redemptions

By redeeming this reward, you agree to these terms.""",
                                  style: textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 110.h),
                        ]);
                  },
                  error: (error, stack) => Container(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showQRCodeDialog(BuildContext context) {
    final rewardState = ref.read(rewardDetailViewModelProvider);

    rewardState.whenData((redemptions) {
      if (redemptions.isNotEmpty) {
        final redemption = redemptions.first as UserRedemptionEntity;

        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "QR Code",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          redemption.rewardName,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          child: redemption.qrCode != null
                              ? QrImageView(
                                  data: redemption.qrCode!,
                                  version: QrVersions.auto,
                                  size: 200.w,
                                  backgroundColor: Colors.white,
                                  gapless: false,
                                  errorStateBuilder: (cxt, err) {
                                    return Container(
                                      child: Center(
                                        child: Text(
                                          "Error generating QR code",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: 200.w,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.qr_code,
                                            size: 60.w, color: Colors.grey),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'No QR Code Available',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                        SizedBox(height: 16.h),
                                      ],
                                    ),
                                  ),
                                ),
                        ),

                        SizedBox(height: 16.h),

                        // QR Code Text
                        if (redemption.qrCode != null) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              redemption.qrCode!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontFamily: 'Courier',
                                    fontSize: 12.sp,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline,
                                    color: Colors.blue.shade700, size: 20.w),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    'Show this QR code to staff for validation',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.blue.shade700,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Status',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: redemption.isUsed
                                          ? Colors.red.shade100
                                          : Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      redemption.isUsed ? 'Used' : 'Active',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: redemption.isUsed
                                                ? Colors.red
                                                : Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              if (redemption.expiryDate != null)
                                Column(
                                  children: [
                                    Text(
                                      'Expires',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _countdownText.isEmpty
                                          ? 'Loading...'
                                          : _countdownText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _isExpired
                                                ? Colors.red
                                                : Colors.orange,
                                          ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ));
      }
    });
  }
}
