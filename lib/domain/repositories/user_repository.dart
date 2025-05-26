import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getCurrentUser();
  Future<void> updateUserPoints(String userId, int points);
  Future<void> updateStampProgress(String userId, int stamps);
  Future<void> updateUserProfile(String userId, String name);
}