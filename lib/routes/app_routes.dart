import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/history/view/history_screen.dart';
import 'package:espress_yo_self/presentation/profile/view/edit_profile_screen.dart';
import 'package:espress_yo_self/presentation/profile/view/profile_screen.dart';
import 'package:espress_yo_self/presentation/rewards/view/rewards_screen.dart';
import 'package:espress_yo_self/presentation/main/main_shell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/auth/view/auth_screen.dart';
import '../presentation/home/view/home_screen.dart';
import '../presentation/qr/view/qr_screen.dart';
import '../presentation/userform/view/userform_screen.dart';
import 'error_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routerNeglect: true,
    redirect: (context, state) {
      final user = authState.asData?.value;
      final isLoggedIn = user != null;
      final isLoggingIn = state.matchedLocation == '/login';
      final isUpdatingProfile = state.matchedLocation == '/userform';
      final fromProfile = state.uri.queryParameters['fromProfile'] == 'true';

      if (isLoggedIn && fromProfile && state.matchedLocation == '/home') {
        debugPrint(
            "ROUTER: Bypassing redirect because coming from profile update");
        return null;
      }

      if (!isLoggedIn) {
        return '/login';
      }

      if (user.displayName == null && !isUpdatingProfile) {
        return '/userform';
      }

      if (isLoggedIn && user.displayName != null && isLoggingIn) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => AuthScreen(),
        name: 'Login',
      ),
      GoRoute(
        path: '/userform',
        builder: (context, state) => UserformScreen(),
        name: 'UserForm',
      ),
      GoRoute(
        path: '/qr',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const QrScreen(),
        ),
        name: 'QR',
      ),
      GoRoute(
        path: '/edit-profile',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const EditProfileScreen(),
        ),
        name: 'EditProfile',
      ),
      ShellRoute(
        builder: (context, state, child) => MainShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => '/home',
          ),
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const HomeScreen(),
            ),
            name: 'Home',
          ),
          GoRoute(
            path: '/rewards',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const RewardsScreen(),
            ),
            name: 'Rewards',
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const HistoryScreen(),
            ),
            name: 'History',
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const ProfileScreen(),
            ),
            name: 'Profile',
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});
