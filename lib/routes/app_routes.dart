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
      // Get current state from ref
      final authState = ref.read(authViewModelProvider);
      final user = authState.asData?.value;
      final isLoggedIn = user != null;
      final isLoggingIn = state.matchedLocation == '/login';
      final isUpdatingProfile = state.matchedLocation == '/userform';
      
      // For debugging
      print("ROUTER: Logged in: $isLoggedIn, Current route: ${state.matchedLocation}");
      if (user != null) {
        print("ROUTER: User displayName: ${user.displayName}");
      }
      
      // Don't redirect during profile update process
      if (isUpdatingProfile) {
        return null;
      }
      
      // If not logged in and not on login screen, go to login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      
      // If logged in but needs to fill out profile, go to userform
      if (isLoggedIn && user.displayName == null && !isUpdatingProfile) {
        return '/userform';
      }
      
      // If logged in and on login screen, go to home
      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }
      
      // Don't redirect otherwise
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
