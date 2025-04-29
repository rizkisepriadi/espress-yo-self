import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/auth_service.dart';

class AuthViewModel extends StateNotifier<AsyncValue<User?>> {
  final AuthService authService;

  AuthViewModel(this.authService) : super(const AsyncData(null)) {
    _listenAuthState();
  }

  Stream<User?> get authStateChanges => authService.authStateChanges;

  void _listenAuthState() {
    authService.authStateChanges.listen((user) {
      print("User state changed: $user");
      state = AsyncData(user);
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      await authService.signInWithEmail(email, password);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    state = const AsyncLoading();

    try {
      await authService.registerWithEmail(email, password);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();

    try {
      await authService.signInWithGoogle();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await authService.signOut();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
