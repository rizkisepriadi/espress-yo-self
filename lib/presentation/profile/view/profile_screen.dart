import 'package:cached_network_image/cached_network_image.dart';
import 'package:espress_yo_self/presentation/profile/widget/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int selectedIndex = 3;
  bool notificationsEnabled = false;
  bool darkThemeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final userState = ref.watch(getUserViewModelProvider);
    final userName = userState.asData?.value.name;
    final userEmail = userState.asData?.value.email;
    final photoUrl = userState.asData?.value.profileImageUrl;

    return SafeArea(
        child: Center(
      child: Column(
        children: [
          _buildProfileAvatar(photoUrl, colorScheme),
          SizedBox(height: 8.h),
          Text(
            userName!,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          Text(userEmail!,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              )),
          SizedBox(height: 8.h),
          SizedBox(
            width: 150.w,
            child: OutlinedButton(
              onPressed: () {
                context.push('/edit-profile');
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text("Edit Profile"),
            ),
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Preferences",
                textAlign: TextAlign.start,
                style: textTheme.headlineSmall,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SettingButton(
            icon: Icons.notifications,
            label: "Push Notifications",
            isToggle: true,
            toggleValue: notificationsEnabled,
            onToggleChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          SizedBox(height: 16.h),
          SettingButton(
            icon: Icons.dark_mode,
            label: "Dark Theme",
            isToggle: true,
            toggleValue: darkThemeEnabled,
            onToggleChanged: (value) {
              setState(() {
                darkThemeEnabled = value;
              });
            },
          ),
          SizedBox(height: 16.h),
          SettingButton(
            icon: Icons.logout,
            label: "Logout",
            onTap: () {
              ref.read(authViewModelProvider.notifier).signOut();
            },
            colorIcon: colorScheme.onError,
            colorBackground: colorScheme.error,
          )
        ],
      ),
    ));
  }

  Widget _buildProfileAvatar(String? photoUrl, ColorScheme colorScheme) {
    return CircleAvatar(
      radius: 60.r,
      backgroundColor: Colors.grey.shade100,
      child: photoUrl != null && photoUrl.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: photoUrl,
                width: 116.w,
                height: 116.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) {
                  debugPrint('CachedNetworkImage error: $error');
                  return SvgPicture.asset(
                    "assets/svgs/profile_default.svg",
                    width: 160.w,
                    height: 160.h,
                  );
                },
              ),
            )
          : SvgPicture.asset(
              "assets/svgs/profile_default.svg",
              width: 160.w,
              height: 160.h,
            ),
    );
  }
}
