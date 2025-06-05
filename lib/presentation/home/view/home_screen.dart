import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';
import 'package:espress_yo_self/presentation/common/menu_box.dart';
import 'package:espress_yo_self/presentation/home/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../di/di.dart';
import '../../common/coupon_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncUser = ref.watch(authViewModelProvider);
    final userState = ref.watch(currentUserProvider);

    final stampState = ref.watch(userStampProgressProvider);
    final rewardState = ref.watch(homeRewardsProvider);
    final historyState = ref.watch(homeTransactionsProvider);

    final points = userState.asData?.value.totalPoints ?? 0;
    final filledCups = stampState.asData?.value.stampsCollected ?? 0;
    final userName = userState.asData?.value.name;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _appbar(textTheme, asyncUser, userName, colorScheme),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  PointsCard(
                    points: points,
                    filledCups: filledCups,
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your Rewards",
                            style: textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 30.sp,
                          ),
                          onPressed: () {
                            context.goNamed('Rewards');
                          },
                        ),
                      ],
                    ),
                  ),
                  rewardState.when(
                      loading: () {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      error: (error, stack) => Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 48.sp,
                                  color: colorScheme.error,
                                ),
                                SizedBox(height: 8.h),
                                Text('Error: $error'),
                                ElevatedButton(
                                    onPressed: () {
                                      ref.invalidate(homeRewardsProvider);
                                    },
                                    child: Text('Retry')),
                              ],
                            ),
                          ),
                      data: (rewards) {
                        if (rewards.isEmpty) {
                          return SizedBox(
                            height: 100.h,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8.h),
                                  Text("No rewards available",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ],
                              ),
                            ),
                          );
                        }

                        final userRedemptions =
                            rewards.whereType<UserRedemptionEntity>().toList();

                        if (userRedemptions.isEmpty) {
                          return SizedBox(
                            height: 100.h,
                            child: Center(
                                child: Text("No rewards available",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge)),
                          );
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: userRedemptions.length,
                            itemBuilder: (context, index) {
                              final rewardData = userRedemptions[index];
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: CouponCard(
                                  title: rewardData.rewardName,
                                  description: rewardData.rewardDescription,
                                  onPressed: () {},
                                ),
                              );
                            });
                      }),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Purchase History",
                            style: textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 30.sp,
                          ),
                          onPressed: () {
                            context.goNamed('History');
                          },
                        ),
                      ],
                    ),
                  ),
                  historyState.when(
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
                          SizedBox(height: 8.h),
                          Text('Error: $error'),
                          ElevatedButton(
                              onPressed: () {
                                ref.invalidate(homeTransactionsProvider);
                              },
                              child: Text('Retry')),
                        ],
                      ),
                    ),
                    data: (transactions) {
                      if (transactions.isEmpty) {
                        return SizedBox(
                          height: 100.h,
                          child: Center(
                              child: Text('No transaction history.',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge)),
                        );
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h, top: 4.h),
                              child: MenuBox(
                                  title: transaction.title,
                                  points: transaction.pointsEarned,
                                  image: transaction.image250Url ?? ''),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  AppBar _appbar(TextTheme textTheme, AsyncValue<User?> asyncUser,
      String? userName, ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: colorScheme.surface,
      title: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: textTheme.bodyLarge,
            ),
            Text(
              asyncUser.asData?.value?.displayName ?? userName!,
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      actions: [
        Container(
          width: 40.w,
          height: 40.h,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.onSurface,
                width: 2,
              )),
          child: IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }
}
