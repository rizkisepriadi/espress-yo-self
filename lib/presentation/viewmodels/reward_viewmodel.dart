import 'package:espress_yo_self/domain/usecases/get_reward_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RewardViewmodel extends StateNotifier<AsyncValue<List<dynamic>>> {
  final GetAllRewardsUsecase getAllRewardsUsecase;
  final GetActiveRewardsUsecase getActiveRewardsUsecase;
  final GetRewardByIdUsecase getRewardByIdUsecase;
  final RedeemRewardUsecase redeemRewardUsecase;
  final GetUserRedemptionsUsecase getUserRedemptionsUsecase;
  final HasUserRedeemedRewardUsecase hasUserRedeemedRewardUsecase;
  final MarkRedemptionAsUsedUsecase markRedemptionAsUsedUsecase;

  RewardViewmodel({
    required this.getAllRewardsUsecase,
    required this.getActiveRewardsUsecase,
    required this.getRewardByIdUsecase,
    required this.redeemRewardUsecase,
    required this.getUserRedemptionsUsecase,
    required this.hasUserRedeemedRewardUsecase,
    required this.markRedemptionAsUsedUsecase,
  }) : super(const AsyncValue.loading()) {
    fetchAllRewards();
  }

  Future<void> fetchAllRewards() async {
    try {
      final reward = await getAllRewardsUsecase.call();
      if (!mounted) return;
      state = AsyncValue.data(reward);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchActiveRewards() async {
    try {
      final reward = await getActiveRewardsUsecase.call();
      state = AsyncValue.data(reward);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchRewardById(String rewardId) async {
    try {
      final reward = await getRewardByIdUsecase.call(rewardId);
      if (reward != null) {
        state = AsyncValue.data([reward]);
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> redeemReward(
    String userId,
    String rewardId,
    int pointsRequired,
  ) async {
    state = AsyncValue.loading();
    try {
      await redeemRewardUsecase.call(userId, rewardId, pointsRequired);
      await fetchAllRewards();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchUserRedemptions(String userId) async {
    try {
      final redemptions = await getUserRedemptionsUsecase.call(userId);
      state = AsyncValue.data(redemptions);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<bool> checkUserRedeemedReward(String userId, String rewardId) async {
    try {
      return await hasUserRedeemedRewardUsecase.call(userId, rewardId);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  Future<void> markRedemptionAsUsed(String redemptionId, String staffId) async {
    state = AsyncValue.loading();
    try {
      await markRedemptionAsUsedUsecase.call(redemptionId, staffId);
      await fetchAllRewards();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
