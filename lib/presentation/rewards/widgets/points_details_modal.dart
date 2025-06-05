import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PointsDetailsModal extends ConsumerWidget {
  final int points;
  final int filledCups;

  const PointsDetailsModal({
    super.key,
    required this.points,
    required this.filledCups,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.of(context).size.height * 1.0,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.h,
            height: 4.w,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Points & Reward System',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: 28.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurrentStatusCard(context, colorScheme, textTheme),

                  SizedBox(height: 20.h),

                  // How to Earn Points
                  _buildHowToEarnSection(context, colorScheme, textTheme),

                  SizedBox(height: 20.h),

                  // Stamp System
                  _buildStampSystemSection(context, colorScheme, textTheme),

                  SizedBox(height: 20.h),

                  // Eco-Friendly Bonus
                  _buildEcoFriendlySection(context, colorScheme, textTheme),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStatusCard(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(204),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: colorScheme.onPrimary,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Your Current Status',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusItem(
                'Total Points',
                '$points pts',
                Icons.stars,
                colorScheme,
                textTheme,
              ),
              _buildStatusItem(
                'Coffee Stamps',
                '$filledCups/5',
                Icons.local_cafe,
                colorScheme,
                textTheme,
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildHowToEarnSection(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.primary.withAlpha(61),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: colorScheme.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text("How to Earn Points",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ))
            ],
          ),
          SizedBox(height: 12.h),
          _buildEarnMethodItem(
            'Purchase Coffee',
            'Scan QR code after purchase',
            '1 pts/Rp. 1000 spent',
            colorScheme,
            textTheme,
          ),
          SizedBox(height: 12.h),
          _buildEarnMethodItem(
            'Eco-Friendly Coffee',
            'Buy eco products',
            '+50% bonus points',
            colorScheme,
            textTheme,
          ),
          SizedBox(height: 12.h),
          _buildEarnMethodItem(
            'Complete Challenges',
            'Participate in Special events',
            'Bonus Points',
            colorScheme,
            textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildStampSystemSection(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    const int totalCups = 5;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(204),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_cafe,
                color: colorScheme.onPrimary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Coffee Stamp System',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Stack(
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
          SizedBox(height: 12.h),
          Text(
            'How it works:',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          Text(
            '• Get 1 stamp for every coffee purchase\n'
            '• Collect 10 stamps = 1 FREE coffee\n'
            '• Stamps reset after redemption\n'
            '• Valid for 6 months from first stamp',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEcoFriendlySection(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.eco,
                color: colorScheme.onTertiaryContainer,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Eco-Friendly Bonus',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Get 50% bonus points for eco-friendly purchases!',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Eco-friendly products include:",
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
          Text(
            '• Organic Fair Trade Coffee\n'
            '• Sustainable Cold Brew\n'
            '• Plant-Based Latte\n'
            '• Products with reusable cups',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onTertiaryContainer,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    String label,
    String value,
    IconData icon,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      width: 165.w,
      height: 100.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withAlpha(39),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: colorScheme.onPrimary,
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onPrimary.withAlpha(204),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEarnMethodItem(
    String title,
    String subtitle,
    String points,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(subtitle, style: textTheme.bodySmall)
            ],
          ),
        ),
        Text(
          points,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
