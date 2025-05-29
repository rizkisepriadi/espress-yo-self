import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';
import 'package:espress_yo_self/presentation/common/bottom_navigation.dart';
import 'package:espress_yo_self/presentation/common/coupon_card.dart';
import 'package:espress_yo_self/presentation/common/floating_button.dart';
import 'package:espress_yo_self/presentation/rewards/widgets/points_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardsScreen extends ConsumerStatefulWidget {
  const RewardsScreen({super.key});

  @override
  ConsumerState<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends ConsumerState<RewardsScreen> {
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = ref.read(getUserViewModelProvider);
      final userId = userState.asData?.value.id;
      if (userId != null) {
        ref.read(rewardViewModelProvider.notifier).fetchUserRedemptions(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(getUserViewModelProvider);
    final rewardState = ref.watch(rewardViewModelProvider);
    final points = userState.asData?.value.totalPoints ?? 0;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButton(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
        child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PointsCard(points: points),
                    SizedBox(height: 16.h),
                    Text("Your Rewards", style: textTheme.headlineSmall),
                    SizedBox(height: 24.h),
                    _buildRewardsList(rewardState),
                  ],
                ))),
      ),
    );
  }

  Widget _buildRewardsList(AsyncValue<List<dynamic>> rewardState) {
    final colorScheme = Theme.of(context).colorScheme;

    return rewardState.when(
        loading: () => Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stack) => Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error,
                    size: 48.sp,
                    color: colorScheme.error,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text('Error: $error'),
                  ElevatedButton(
                      onPressed: () {
                        final userState = ref.read(getUserViewModelProvider);
                        final userId = userState.asData?.value.id;
                        if (userId != null) {
                          ref
                              .read(rewardViewModelProvider.notifier)
                              .fetchUserRedemptions(userId);
                        }
                      },
                      child: Text('Retry')),
                ],
              ),
            ),
        data: (rewards) {
          if (rewards.isEmpty) {
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      size: 48.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h),
                    Text("No rewards available",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final rewardData = rewards[index];

                if (rewardData is UserRedemptionEntity) {
                  return CouponCard(
                    title: rewardData.rewardName,
                    description: rewardData.rewardDescription,
                    onPressed: () {},
                  );
                } else {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    child: ListTile(
                      title: Text('Invalid reward data'),
                      subtitle: Text('Type: ${rewardData.runtimeType}'),
                      trailing: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                }
              });
        });
  }
}
