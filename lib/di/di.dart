import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/data/repositories/user_repository_impl.dart';
import 'package:espress_yo_self/data/repositories/reward_repository_impl.dart';
import 'package:espress_yo_self/data/repositories/stamp_progress_repository_impl.dart';
import 'package:espress_yo_self/data/repositories/transactions_repository_impl.dart';
import 'package:espress_yo_self/data/services/auth_service.dart';
import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/reward_repository.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';
import 'package:espress_yo_self/domain/repositories/stamp_progress_repository.dart';
import 'package:espress_yo_self/domain/repositories/transactions_repository.dart';
import 'package:espress_yo_self/domain/usecases/get_user_usecase.dart';
import 'package:espress_yo_self/domain/usecases/get_reward_usecase.dart';
import 'package:espress_yo_self/domain/usecases/stamp_progress_usecase.dart';
import 'package:espress_yo_self/domain/usecases/transactions_usecase.dart';
import 'package:espress_yo_self/presentation/viewmodels/auth_viewmodel.dart';
import 'package:espress_yo_self/presentation/viewmodels/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== FIREBASE PROVIDERS ====================
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// ==================== REPOSITORY PROVIDERS ====================

// User Repository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final authService = ref.watch(authServiceProvider);
  return UserRepositoryImpl(firestore: firestore, authService: authService);
});

// Reward Repository
final rewardRepositoryProvider = Provider<RewardRepository>((ref) {
  return RewardRepositoryImpl();
});

// Stamp Progress Repository
final stampProgressRepositoryProvider = Provider<StampProgressRepository>((ref) {
  return StampProgressRepositoryImpl();
});

// Transactions Repository
final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepositoryImpl();
});

// ==================== USER USECASES ====================

final getUserUseCaseProvider = Provider<GetUserUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUsecase(repository);
});

final updateUserPointsUseCaseProvider = Provider<UpdateUserPointsUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUserPointsUsecase(repository);
});

final updateStampProgressUseCaseProvider = Provider<UpdateStampProgressUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateStampProgressUsecase(repository);
});

final updateUserProfileUseCaseProvider = Provider<UpdateUserProfileUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUserProfileUsecase(repository);
});

// ==================== REWARD USECASES ====================

final getAllRewardsUseCaseProvider = Provider<GetAllRewardsUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return GetAllRewardsUsecase(repository);
});

final getActiveRewardsUseCaseProvider = Provider<GetActiveRewardsUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return GetActiveRewardsUsecase(repository);
});

final getRewardByIdUseCaseProvider = Provider<GetRewardByIdUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return GetRewardByIdUsecase(repository);
});

final redeemRewardUseCaseProvider = Provider<RedeemRewardUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return RedeemRewardUsecase(repository);
});

final getUserRedemptionsUseCaseProvider = Provider<GetUserRedemptionsUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return GetUserRedemptionsUsecase(repository);
});

final hasUserRedeemedRewardUseCaseProvider = Provider<HasUserRedeemedRewardUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return HasUserRedeemedRewardUsecase(repository);
});

final markRedemptionAsUsedUseCaseProvider = Provider<MarkRedemptionAsUsedUsecase>((ref) {
  final repository = ref.watch(rewardRepositoryProvider);
  return MarkRedemptionAsUsedUsecase(repository);
});

// ==================== STAMP PROGRESS USECASES ====================

final getStampProgressUseCaseProvider = Provider<GetStampProgressUsecase>((ref) {
  final repository = ref.watch(stampProgressRepositoryProvider);
  return GetStampProgressUsecase(repository);
});

final updateStampProgressRepoUseCaseProvider = Provider<UpdateStampProgressRepoUsecase>((ref) {
  final repository = ref.watch(stampProgressRepositoryProvider);
  return UpdateStampProgressRepoUsecase(repository);
});

// ==================== TRANSACTIONS USECASES ====================

final addTransactionUseCaseProvider = Provider<AddTransactionUsecase>((ref) {
  final repository = ref.watch(transactionsRepositoryProvider);
  return AddTransactionUsecase(repository);
});

final getUserTransactionsUseCaseProvider = Provider<GetUserTransactionsUsecase>((ref) {
  final repository = ref.watch(transactionsRepositoryProvider);
  return GetUserTransactionsUsecase(repository);
});

// ==================== VIEWMODELS ====================

final getUserViewModelProvider = StateNotifierProvider<UserViewModel, AsyncValue<UserEntity>>((ref) {
  final getUserUsecase = ref.watch(getUserUseCaseProvider);
  final updateUserPointsUsecase = ref.watch(updateUserPointsUseCaseProvider);
  final updateStampProgressUsecase = ref.watch(updateStampProgressUseCaseProvider);
  final updateUserProfileUsecase = ref.watch(updateUserProfileUseCaseProvider);
  return UserViewModel(
    getUserUsecase: getUserUsecase,
    updateUserPointsUsecase: updateUserPointsUsecase,
    updateStampProgressUsecase: updateStampProgressUsecase,
    updateUserProfileUsecase: updateUserProfileUsecase,
  );
});

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthViewModel(authService);
});
