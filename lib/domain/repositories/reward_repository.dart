import 'package:espress_yo_self/domain/entities/reward_entity.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';

abstract class RewardRepository {
  Future<List<RewardEntity>> getAllRewards();
  Future<List<RewardEntity>> getActiveRewards();
  Future<RewardEntity?> getRewardById(String rewardId);
  Future<void> redeemReward(String userId, String rewardId, int pointsRequired);
  Future<List<UserRedemptionEntity>> getUserRedemptions(String userId);
  Future<UserRedemptionEntity?> getRewardRedemptionById(String rewardId);
  Future<bool> hasUserRedeemedReward(String userId, String rewardId);
  Future<void> markRedemptionAsUsed(String redemptionId, String staffId);
}
