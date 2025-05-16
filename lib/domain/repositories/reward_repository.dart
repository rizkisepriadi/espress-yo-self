import 'package:espress_yo_self/domain/entities/reward_entity.dart';

abstract class RewardRepository {
  Future<List<RewardEntity>> getAllRewards();
  Future<RewardEntity?> getRewardById(String rewardId);
  Future<void> redeemReward(String userId, String rewardId, int pointsRequired);
}
