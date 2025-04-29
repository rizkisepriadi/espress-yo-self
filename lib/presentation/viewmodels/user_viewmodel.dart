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
}