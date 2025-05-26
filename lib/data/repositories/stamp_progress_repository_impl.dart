import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';
import 'package:espress_yo_self/domain/repositories/stamp_progress_repository.dart';
import 'package:espress_yo_self/data/models/stamp_progress/stamp_progress_model.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

class StampProgressRepositoryImpl implements StampProgressRepository {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'stamp_progress';

  @override
  Future<StampProgressEntity> getStampProgress(String userId) {
    return safeCall(() async {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      
      if (!doc.exists) {
        await _createDefaultStampProgress(userId);
        
        return StampProgressEntity(
          userId: userId,
          stampsCollected: 0,
          stampsRequired: 10,
          lastUpdated: DateTime.now(),
        );
      }
      
      final data = doc.data()!;
      final model = StampProgressModel.fromJson({
        'user_id': userId,
        ...data,
      });
      return model.toEntity();
    }, label: 'getStampProgress');
  }

  @override
  Future<void> updateStampProgress(String userId, int stamps) {
    return safeCall(() async {
      await _firestore.collection(_collection).doc(userId).set({
        'user_id': userId,
        'stamps_collected': stamps,
        'stamps_required': 10,
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }, label: 'updateStampProgress');
  }

  Future<void> _createDefaultStampProgress(String userId) async {
    await _firestore.collection(_collection).doc(userId).set({
      'user_id': userId,
      'stamps_collected': 0,
      'stamps_required': 10,
      'last_updated': FieldValue.serverTimestamp(),
    });
  }
}
