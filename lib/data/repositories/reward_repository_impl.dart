import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/domain/entities/reward_entity.dart';
import 'package:espress_yo_self/domain/repositories/reward_repository.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

class RewardRepositoryImpl implements RewardRepository {
  final CollectionReference _rewardsCollection =
      FirebaseFirestore.instance.collection('rewards');

  @override
  Future<void> redeemReward(
      String userId, String rewardId, int pointsRequired) async {
    return await safeCall(() async {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final rewardDoc = _rewardsCollection.doc(rewardId);

      final userSnapshot = await userDoc.get();
      final currentPoints = userSnapshot['total_points'] ?? 0;
      if (currentPoints < pointsRequired) {
        throw Exception('Not enough points');
      }

      await userDoc.update({
        'total_points': FieldValue.increment(-pointsRequired),
        'redeemed_rewards': FieldValue.arrayUnion([rewardId])
      });

      await rewardDoc.update({'is_claimed': true});
    }, label: 'redeemReward');
  }

  @override
  Future<List<RewardEntity>> getAllRewards() async {
    return await safeCall(() async {
      final querySnapshot = await _rewardsCollection.get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return RewardEntity(
          id: doc.id,
          name: data['name'],
          description: data['description'],
          pointsRequired: data['points_required'],
          isClaimed: data['is_claimed'],
        );
      }).toList();
    }, label: 'getAllRewards');
  }

  @override
  Future<RewardEntity?> getRewardById(String rewardId) async {
    return await safeCall(() async {
      final doc = await _rewardsCollection.doc(rewardId).get();
      if (!doc.exists) return null;

      final data = doc.data()! as Map<String, dynamic>;
      return RewardEntity(
        id: rewardId,
        name: data['name'],
        description: data['description'],
        pointsRequired: data['points_required'],
        isClaimed: data['is_claimed'],
      );
    }, label: 'getRewardById');
  }
}
