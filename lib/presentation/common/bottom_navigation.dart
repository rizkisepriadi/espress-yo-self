import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigation(
      {super.key, this.currentIndex = 0, required this.onTap});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomAppBar(
      color: colorScheme.surfaceContainer,
      child: SizedBox(
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavItem(
                icon: Icons.home,
                label: "Home",
                selected: widget.currentIndex == 0,
                onTap: () {
                  context.go('/home');
                  widget.onTap(0);
                }),
            _BottomNavItem(
                icon: Icons.emoji_events,
                label: "Rewards",
                selected: widget.currentIndex == 1,
                onTap: () {
                  context.go('/rewards');
                  widget.onTap(1);
                }),
            SizedBox(
              width: 72.w,
            ),
            _BottomNavItem(
                icon: Icons.history,
                label: "History",
                selected: widget.currentIndex == 2,
                onTap: () {
                  context.go('/history');
                  widget.onTap(2);
                }),
            _BottomNavItem(
                icon: Icons.person,
                label: "Profile",
                selected: widget.currentIndex == 3,
                onTap: () {
                  context.go('/profile');
                  widget.onTap(3);
                }),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final color = selected ? colorScheme.primary : colorScheme.onSurface;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30.w),
            SizedBox(height: 4.h),
            Text(
              label,
              style: textTheme.labelMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: color),
            )
          ],
        ),
      ),
    );
  }
}
