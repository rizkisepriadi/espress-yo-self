import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:espress_yo_self/domain/usecases/get_user_usecase.dart';

class UserViewModel extends StateNotifier<AsyncValue<UserEntity>> {
  final GetUserUsecase getUserUsecase;
  final UpdateUserPointsUsecase updateUserPointsUsecase;
  final UpdateStampProgressUsecase updateStampProgressUsecase;
  final UpdateUserProfileUsecase updateUserProfileUsecase;

  UserViewModel({
    required this.getUserUsecase,
    required this.updateUserPointsUsecase,
    required this.updateStampProgressUsecase,
    required this.updateUserProfileUsecase,
  }) : super(const AsyncValue.loading()) {
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final user = await getUserUsecase.call();
      if (!mounted) return;
      state = AsyncValue.data(user);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateUserPoints(String userId, int points) async {
    state = const AsyncValue.loading();
    try {
      await updateUserPointsUsecase.call(userId, points);
      await fetchUser();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStampProgress(String userId, int stamps) async {
    state = const AsyncValue.loading();
    try {
      await updateStampProgressUsecase.call(userId, stamps);
      await fetchUser();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateUserProfile(String userId, String displayName) async {
    if (!mounted) return;

    state = const AsyncValue.loading();
    try {
      await updateUserProfileUsecase.call(userId, displayName);

      if (!mounted) return;
      try {
        await fetchUser();
        print("User profile updated in Firestore");
      } catch (e) {
        print("Profile updated but couldn't fetch updated user: $e");
      }
    } catch (e, stack) {
      print("Error updating user profile: $e");

      if (!mounted) return;

      state = AsyncValue.error(e, stack);
    }
  }
}
