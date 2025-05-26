import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';

abstract class StampProgressRepository {
  Future<StampProgressEntity> getStampProgress(String userId);
  Future<void> updateStampProgress(String userId, int stamps);
}
