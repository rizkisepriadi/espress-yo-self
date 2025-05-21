import 'package:espress_yo_self/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/auth/view/auth_screen.dart';
import '../presentation/home/view/home_screen.dart';
import '../presentation/userform/view/userform_screen.dart';
import 'error_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);
  
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routerNeglect: true,
    redirect: (context, state) {
      // Get current user from state
      final user = authState.asData?.value;
      final isLoggedIn = user != null;
      final isLoggingIn = state.matchedLocation == '/login';
      final isUpdatingProfile = state.matchedLocation == '/userform';
      
      // Check for parameter that bypasses profile check
      final fromProfile = state.uri.queryParameters['fromProfile'] == 'true';
      
      // Special case: coming from profile update - don't redirect
      if (isLoggedIn && fromProfile && state.matchedLocation == '/home') {
        debugPrint("ROUTER: Bypassing redirect because coming from profile update");
        return null;
      }
      
      // For debugging
      debugPrint("ROUTER: Logged in: $isLoggedIn, Current route: ${state.matchedLocation}");
      if (user != null) {
        debugPrint("ROUTER: User displayName: ${user.displayName}");
      }
      
      // Not logged in - go to login
      if (!isLoggedIn) {
        return '/login';
      }
      
      // Logged in but no display name - go to userform
      if (user!.displayName == null && !isUpdatingProfile) {
        return '/userform';
      }
      
      // Logged in with display name, but on login screen - go to home
      if (isLoggedIn && user.displayName != null && isLoggingIn) {
        return '/home';
      }
      
      // Don't redirect
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => AuthScreen(),
        name: 'Login',
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
        name: 'Home',
      ),
      GoRoute(
        path: '/userform',
        builder: (context, state) => UserformScreen(),
        name: 'UserForm',
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});
