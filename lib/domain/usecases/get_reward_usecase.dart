import 'package:espress_yo_self/domain/entities/reward_entity.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';
import 'package:espress_yo_self/domain/repositories/reward_repository.dart';

class GetAllRewardsUsecase {
  final RewardRepository repository;
  GetAllRewardsUsecase(this.repository);
  Future<List<RewardEntity>> call() async {
    return await repository.getAllRewards();
  }
}

class GetActiveRewardsUsecase {
  final RewardRepository repository;
  GetActiveRewardsUsecase(this.repository);
  Future<List<RewardEntity>> call() async {
    return await repository.getActiveRewards();
  }
}

class GetRewardByIdUsecase {
  final RewardRepository repository;
  GetRewardByIdUsecase(this.repository);
  Future<RewardEntity?> call(String rewardId) async {
    return await repository.getRewardById(rewardId);
  }
}

class RedeemRewardUsecase {
  final RewardRepository repository;
  RedeemRewardUsecase(this.repository);
  Future<void> call(String userId, String rewardId, int pointsRequired) async {
    return await repository.redeemReward(userId, rewardId, pointsRequired);
  }
}

class GetUserRedemptionsUsecase {
  final RewardRepository repository;
  GetUserRedemptionsUsecase(this.repository);
  Future<List<UserRedemptionEntity>> call(String userId) async {
    return await repository.getUserRedemptions(userId);
  }
}

class HasUserRedeemedRewardUsecase {
  final RewardRepository repository;
  HasUserRedeemedRewardUsecase(this.repository);
  Future<bool> call(String userId, String rewardId) async {
    return await repository.hasUserRedeemedReward(userId, rewardId);
  }
}

class MarkRedemptionAsUsedUsecase {
  final RewardRepository repository;
  MarkRedemptionAsUsedUsecase(this.repository);
  Future<void> call(String redemptionId, String staffId) async {
    return await repository.markRedemptionAsUsed(redemptionId, staffId);
  }
}