import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';
import 'package:espress_yo_self/domain/repositories/stamp_progress_repository.dart';

class GetStampProgressUsecase {
  final StampProgressRepository repository;
  GetStampProgressUsecase(this.repository);
  Future<StampProgressEntity> call() async {
    return await repository.getStampProgress();
  }
}

class UpdateStampProgressRepoUsecase {
  final StampProgressRepository repository;
  UpdateStampProgressRepoUsecase(this.repository);
  Future<void> call(String userId, int stamps) async {
    return await repository.updateStampProgress(userId, stamps);
  }
}