import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/data/repositories/user_repository_impl.dart';
import 'package:espress_yo_self/data/services/auth_service.dart';
import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';
import 'package:espress_yo_self/domain/usecases/get_user_usecase.dart';
import 'package:espress_yo_self/presentation/viewmodels/auth_viewmodel.dart';
import 'package:espress_yo_self/presentation/viewmodels/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase Intance
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// User Repository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final authService = ref.watch(authServiceProvider);
  return UserRepositoryImpl(firestore: firestore, authService: authService);
});

// Get User Usecase
final getUserUseCaseProvider = Provider<GetUserUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUsecase(repository);
});

// ViewModel
final getUserViewModelProvider =
    StateNotifierProvider.autoDispose<UserViewModel, AsyncValue<UserEntity>>(
        (ref) {
  final getUserUsecase = ref.watch(getUserUseCaseProvider);
  return UserViewModel(getUserUsecase: getUserUsecase);
});

// AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// AuthViewModel
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthViewModel(authService);
});
