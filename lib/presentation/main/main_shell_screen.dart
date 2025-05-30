import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../common/floating_button.dart';

class MainShellScreen extends ConsumerStatefulWidget {
  final Widget child;

  const MainShellScreen({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends ConsumerState<MainShellScreen> {
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocation = GoRouterState.of(context).uri.toString();
    final newIndex = _getIndexFromLocation(currentLocation);
    if (newIndex != currentIndex) {
      setState(() {
        currentIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
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
              selected: currentIndex == 0,
              onTap: () => _navigateToIndex(0, '/home'),
            ),
            _BottomNavItem(
              icon: Icons.emoji_events,
              label: "Rewards",
              selected: currentIndex == 1,
              onTap: () => _navigateToIndex(1, '/rewards'),
            ),
            SizedBox(width: 72.w),
            _BottomNavItem(
              icon: Icons.history,
              label: "History",
              selected: currentIndex == 2,
              onTap: () => _navigateToIndex(2, '/history'),
            ),
            _BottomNavItem(
              icon: Icons.person,
              label: "Profile",
              selected: currentIndex == 3,
              onTap: () => _navigateToIndex(3, '/profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToIndex(int index, String route) {
    setState(() {
      currentIndex = index;
    });
    context.go(route);
  }

  int _getIndexFromLocation(String location) {
    switch (location) {
      case '/home':
        return 0;
      case '/rewards':
        return 1;
      case '/qr':
        return 2;
      case '/history':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 64.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: selected ? 1.1 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: color,
                size: 30.w,
              ),
            ),
            SizedBox(height: 4.h),
            AnimatedDefaultTextStyle(
              style: textTheme.labelMedium?.copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    color: color,
                  ) ??
                  TextStyle(),
              duration: Duration(milliseconds: 200),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
