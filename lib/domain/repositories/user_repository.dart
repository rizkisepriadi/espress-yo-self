import 'dart:io';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getCurrentUser();
  Future<void> updateUserPoints(String userId, int newPoints);
  Future<void> updateStampProgress(String userId, int stamps);
  Future<void> updateUserProfile(String userId, String name,
      {File? profileImage});
}
