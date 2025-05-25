import 'package:espress_yo_self/presentation/common/bottom_navigation.dart';
import 'package:espress_yo_self/presentation/common/floating_button.dart';
import 'package:espress_yo_self/presentation/common/menu_box.dart';
import 'package:espress_yo_self/presentation/home/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../di/di.dart';
import '../../common/coupon_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(authViewModelProvider);
    final userState = ref.watch(getUserViewModelProvider);
    final userName = userState.asData?.value.name;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _appbar(textTheme, asyncUser, userName, colorScheme),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButton(),
        bottomNavigationBar: BottomNavigation(
            currentIndex: 0,
            onTap: (index) {
              // Handle bottom navigation tap
              if (index == 0) {
                // Already on home screen
                return;
              } else if (index == 1) {
                // Navigate to another screen
                context.go('/anotherScreen');
              } else if (index == 2) {
                // Navigate to yet another screen
                context.go('/yetAnotherScreen');
              }
            }),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  PointsCard(),
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
                            // Navigate to rewards screen
                          },
                        ),
                      ],
                    ),
                  ),
                  CouponButton(
                    title: "Get 20% OFF Your Coffee",
                    description:
                        "Today’s your lucky day! Enjoy a freshly brewed cup of your favorite coffee with an exclusive 20% OFF – only for today!",
                    onPressed: () {
                      // Handle coupon button press
                    },
                  ),
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
                            // Navigate to Purchase History screen
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuBox(
                        title: "Ice Coffee",
                        points: 10,
                      ),
                      MenuBox(
                        title: "Ice Coffee",
                        points: 10,
                      ),
                    ],
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
