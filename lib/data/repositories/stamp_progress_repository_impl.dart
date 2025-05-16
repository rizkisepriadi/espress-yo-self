import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';
import 'package:espress_yo_self/domain/repositories/stamp_progress_repository.dart';
import 'package:espress_yo_self/data/models/stamp_progress/stamp_progress_model.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

class StampProgressRepositoryImpl implements StampProgressRepository {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'stamp_progress';

  @override
  Future<StampProgressEntity> getStampProgress() {
    return safeCall(() async {
      final query = await _firestore.collection(_collection).limit(1).get();
      if (query.docs.isEmpty) {
        throw Exception('Stamp progress not found');
      }
      final data = query.docs.first.data();
      final model = StampProgressModel.fromJson(data);
      return model.toEntity();
    }, label: 'getStampProgress');
  }

  @override
  Future<void> redeemReward(String userId, String rewardId) {
    return safeCall(() async {
      await _firestore.collection(_collection).doc(userId).update({
        'reward_redeemed': FieldValue.arrayUnion([rewardId])
      });
    }, label: 'redeemReward');
  }

  @override
  Future<void> updateStampProgress(String userId, int stamps) {
    return safeCall(() async {
      await _firestore.collection(_collection).doc(userId).update({
        'stamps_collected': stamps,
      });
    }, label: 'updateStampProgress');
  }
}
