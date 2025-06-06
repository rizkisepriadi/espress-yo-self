import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/domain/entities/reward_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core Services
import 'package:espress_yo_self/data/services/auth_service.dart';
import 'package:espress_yo_self/data/services/supabase_storage_service.dart';

// Repositories
import 'package:espress_yo_self/data/repositories/user_repository_impl.dart';
import 'package:espress_yo_self/data/repositories/reward_repository_impl.dart';
import 'package:espress_yo_self/data/repositories/stamp_progress_repository_impl.dart';
import 'package:espress_yo_self/data/repositories/transactions_repository_impl.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';
import 'package:espress_yo_self/domain/repositories/reward_repository.dart';
import 'package:espress_yo_self/domain/repositories/stamp_progress_repository.dart';
import 'package:espress_yo_self/domain/repositories/transactions_repository.dart';

// Entities
import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';

// ViewModels (only for auth)
import 'package:espress_yo_self/presentation/viewmodels/auth_viewmodel.dart';

// ==================== CORE SERVICES ====================

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final supabaseStorageServiceProvider =
    Provider<SupabaseStorageService>((ref) => SupabaseStorageService());

// ==================== REPOSITORIES ====================

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    firestore: ref.watch(firebaseFirestoreProvider),
    authService: ref.watch(authServiceProvider),
    storageService: ref.watch(supabaseStorageServiceProvider),
  );
});

final rewardRepositoryProvider =
    Provider<RewardRepository>((ref) => RewardRepositoryImpl());
final stampProgressRepositoryProvider =
    Provider<StampProgressRepository>((ref) => StampProgressRepositoryImpl());
final transactionsRepositoryProvider =
    Provider<TransactionsRepository>((ref) => TransactionsRepositoryImpl());

// ==================== AUTHENTICATION ====================

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  return AuthViewModel(ref.watch(authServiceProvider));
});

// ==================== BACKWARD COMPATIBILITY ====================
// Temporary providers for backward compatibility
final getUserViewModelProvider = currentUserProvider;
final rewardViewModelProvider = userRewardsProvider;
final stampProgressViewModelProvider = userStampProgressProvider;
final transactionsViewModelProvider = userTransactionsProvider;

// ==================== REACTIVE DATA PROVIDERS ====================

// Current authenticated user
final currentUserProvider = FutureProvider<UserEntity>((ref) async {
  final authUser = ref.watch(authViewModelProvider).asData?.value;
  if (authUser?.uid == null) throw 'No authenticated user';

  final repository = ref.watch(userRepositoryProvider);
  return await repository.getCurrentUser();
});

// User transactions (all)
final userTransactionsProvider =
    FutureProvider.autoDispose<List<TransactionsEntitty>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  final repository = ref.watch(transactionsRepositoryProvider);
  return await repository.getUserTransactions(user.id);
});

// User rewards/redemptions (all)
final userRewardsProvider =
    FutureProvider.autoDispose<List<UserRedemptionEntity>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  final repository = ref.watch(rewardRepositoryProvider);
  return await repository.getUserRedemptions(user.id);
});

// User stamp progress
final userStampProgressProvider =
    FutureProvider.autoDispose<StampProgressEntity>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  final repository = ref.watch(stampProgressRepositoryProvider);

  try {
    return await repository.getStampProgress(user.id);
  } catch (e) {
    // Return default if not found
    return StampProgressEntity(
      userId: user.id,
      stampsCollected: 0,
      stampsRequired: 10,
      lastUpdated: DateTime.now(),
    );
  }
});

// Active rewards for shop
final activeRewardsProvider =
    FutureProvider.autoDispose<List<RewardEntity>>((ref) async {
  try {
    final repository = ref.watch(rewardRepositoryProvider);
    final result = await repository.getActiveRewards();

    return result;
  } catch (e) {
    debugPrint('Error in activeRewardsProvider: $e');
    rethrow;
  }
});

// ==================== HOME SCREEN OPTIMIZED DATA ====================

final homeTransactionsProvider =
    FutureProvider.autoDispose<List<TransactionsEntitty>>((ref) async {
  final allTransactions = await ref.watch(userTransactionsProvider.future);
  return allTransactions.take(2).toList();
});

final homeRewardsProvider =
    FutureProvider.autoDispose<List<UserRedemptionEntity>>((ref) async {
  final allRewards = await ref.watch(userRewardsProvider.future);
  return allRewards.take(2).toList();
});

// Combined home data
final homeDataProvider = FutureProvider.autoDispose<HomeData>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  final transactions = await ref.watch(homeTransactionsProvider.future);
  final rewards = await ref.watch(homeRewardsProvider.future);
  final stampProgress = await ref.watch(userStampProgressProvider.future);

  return HomeData(
    user: user,
    recentTransactions: transactions,
    recentRewards: rewards,
    stampProgress: stampProgress,
  );
});

// ==================== ACTION PROVIDERS ====================

final transactionActionsProvider = Provider<TransactionActions>((ref) {
  return TransactionActions(
    transactionRepo: ref.watch(transactionsRepositoryProvider),
    userRepo: ref.watch(userRepositoryProvider),
    stampRepo: ref.watch(stampProgressRepositoryProvider),
  );
});

final rewardActionsProvider = Provider<RewardActions>((ref) {
  return RewardActions(
    rewardRepo: ref.watch(rewardRepositoryProvider),
    userRepo: ref.watch(userRepositoryProvider),
  );
});

final userActionsProvider = Provider<UserActions>((ref) {
  return UserActions(
    userRepo: ref.watch(userRepositoryProvider),
  );
});

// ==================== HELPER CLASSES ====================

class UserActions {
  final UserRepository _userRepo;

  UserActions({
    required UserRepository userRepo,
  }) : _userRepo = userRepo;

  Future<void> updateUserProfile(String userId, String name) async {
    await _userRepo.updateUserProfile(userId, name);
  }

  Future<void> updateUserPoints(String userId, int points) async {
    await _userRepo.updateUserPoints(userId, points);
  }
}

class HomeData {
  final UserEntity user;
  final List<TransactionsEntitty> recentTransactions;
  final List<UserRedemptionEntity> recentRewards;
  final StampProgressEntity stampProgress;

  HomeData({
    required this.user,
    required this.recentTransactions,
    required this.recentRewards,
    required this.stampProgress,
  });
}

class TransactionActions {
  final TransactionsRepository _transactionRepo;
  final UserRepository _userRepo;
  final StampProgressRepository _stampRepo;

  TransactionActions({
    required TransactionsRepository transactionRepo,
    required UserRepository userRepo,
    required StampProgressRepository stampRepo,
  })  : _transactionRepo = transactionRepo,
        _userRepo = userRepo,
        _stampRepo = stampRepo;

  Future<void> addTransaction({
    required String userId,
    required String title,
    required int pointsEarned,
    String? imageUrl,
  }) async {
    // Add transaction
    await _transactionRepo.addTransaction(userId, pointsEarned);

    // Update user points
    await _userRepo.updateUserPoints(userId, pointsEarned);

    // Update stamp progress
    await _stampRepo.updateStampProgress(userId, 1);
  }

  Future<void> addDetailedTransaction({
    required String userId,
    required String title,
    required String description,
    required int points,
    required String transactionType,
    String? orderId,
    String? rewardId,
    double? amount,
    String? imageUrl,
    String? image250Url,
    bool isEcoFriendly = false,
    int ecoPointsBonus = 0,
  }) async {
    await _transactionRepo.addDetailedTransaction(
      userId: userId,
      points: points,
      transactionType: transactionType,
      title: title,
      description: description,
      orderId: orderId,
      rewardId: rewardId,
      amount: amount,
      imageUrl: imageUrl,
      image250Url: image250Url,
      isEcoFriendly: isEcoFriendly,
      ecoPointsBonus: ecoPointsBonus,
    );
  }

  Future<void> addTransactionFromQR({
    required String userId,
    required String qrData,
  }) async {
    await _transactionRepo.addTransactionFromQR(userId: userId, qrData: qrData);
  }
}

class RewardActions {
  final RewardRepository _rewardRepo;
  final UserRepository _userRepo;

  RewardActions({
    required RewardRepository rewardRepo,
    required UserRepository userRepo,
  })  : _rewardRepo = rewardRepo,
        _userRepo = userRepo;

  Future<void> redeemReward({
    required String userId,
    required String rewardId,
    required int pointsCost,
  }) async {
    await _rewardRepo.redeemReward(userId, rewardId, pointsCost);

    // Deduct points from user
    await _userRepo.updateUserPoints(userId, -pointsCost);
  }

  Future<void> markRedemptionAsUsed({
    required String userId,
    required String redemptionId,
  }) async {
    await _rewardRepo.markRedemptionAsUsed(userId, redemptionId);
  }

  Future<bool> hasUserRedeemedReward({
    required String userId,
    required String rewardId,
  }) async {
    return await _rewardRepo.hasUserRedeemedReward(userId, rewardId);
  }
}
