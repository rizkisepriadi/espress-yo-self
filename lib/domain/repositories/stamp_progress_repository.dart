import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';

abstract class StampProgressRepository {
  Future<StampProgressEntity> getStampProgress();
  Future<void> updateStampProgress(String userId, int stamps);
  Future<void> redeemReward(String userId, String rewardId);
}
