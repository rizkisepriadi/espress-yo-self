import 'package:espress_yo_self/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/auth/view/login_screen.dart';
import '../presentation/home/view/home_screen.dart';
import 'error_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);
  final currentUser = authState.asData?.value;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routerNeglect: true,
    redirect: (context, state) {
      final isLoggedIn = currentUser != null;
      print("isLoggedIn: $isLoggedIn");
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/home';

      return null;
    },
    redirectLimit: 1,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});
