import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:espress_yo_self/domain/usecases/get_user_usecase.dart';

class UserViewModel extends StateNotifier<AsyncValue<UserEntity>> {
  final GetUserUsecase getUserUsecase;

  UserViewModel({required this.getUserUsecase}) : super(const AsyncValue.loading()) {
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final user = await getUserUsecase.call();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateUserPoints(String userId, int points) async {
    state = const AsyncValue.loading();
    try {
      await getUserUsecase.repository.updateUserPoints(userId, points);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> redeemReward(String userId, String rewardId) async {
    state = const AsyncValue.loading();
    try {
      await getUserUsecase.repository.redeemReward(userId, rewardId);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStampProgress(String userId, int stamps) async {
    state = const AsyncValue.loading();
    try {
      await getUserUsecase.repository.updateStampProgress(userId, stamps);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateUserProfile(String userId, String name) async {
    state = const AsyncValue.loading();
    try {
      await getUserUsecase.repository.updateUserProfile(userId, name);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
