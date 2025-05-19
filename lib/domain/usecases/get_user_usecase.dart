import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';

class GetUserUsecase {
  final UserRepository repository;

  GetUserUsecase(this.repository);

  Future<UserEntity> call() async {
    return await repository.getCurrentUser();
  }
}

class UpdateUserPointsUsecase {
  final UserRepository repository;

  UpdateUserPointsUsecase(this.repository);

  Future<void> call(String userId, int points) async {
    return await repository.updateUserPoints(userId, points);
  }
}

class RedeemRewardUsecase {
  final UserRepository repository;

  RedeemRewardUsecase(this.repository);

  Future<void> call(String userId, String rewardId) async {
    return await repository.redeemReward(userId, rewardId);
  }
}

class UpdateStampProgressUsecase {
  final UserRepository repository;

  UpdateStampProgressUsecase(this.repository);

  Future<void> call(String userId, int stamps) async {
    return await repository.updateStampProgress(userId, stamps);
  }
}

class UpdateUserProfileUsecase {
  final UserRepository repository;

  UpdateUserProfileUsecase(this.repository);

  Future<void> call(String userId, String displayName) async {
    print("Calling UpdateUserProfileUsecase with $userId, $displayName");
    await repository.updateUserProfile(userId, displayName);
  }
}
