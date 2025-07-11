import 'dart:io';
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

  Future<void> call(String userId, String displayName,
      {File? profileImage}) async {
    await repository.updateUserProfile(userId, displayName,
        profileImage: profileImage);
  }
}
