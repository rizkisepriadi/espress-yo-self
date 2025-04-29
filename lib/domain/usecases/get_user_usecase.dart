import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';

class GetUserUsecase {
  final UserRepository repository;

  GetUserUsecase(this.repository);

  Future<UserEntity> call() async {
    return await repository.getCurrentUser();
  }
}
