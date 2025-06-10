import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/data/models/user_redemption/user_redemption_model.dart';
import 'package:espress_yo_self/domain/entities/reward_entity.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';
import 'package:espress_yo_self/domain/repositories/reward_repository.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

import '../models/reward/reward_model.dart';

class RewardRepositoryImpl implements RewardRepository {
  final CollectionReference _rewardsCollection =
      FirebaseFirestore.instance.collection('rewards');
  final CollectionReference _redemptionsCollection =
      FirebaseFirestore.instance.collection('user_redemptions');

  @override
  Future<List<RewardEntity>> getAllRewards() async {
    return await safeCall(() async {
      final querySnapshot = await _rewardsCollection.get();
      return querySnapshot.docs.map((doc) {
        final model = RewardModel.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
        return model.toEntity();
      }).toList();
    }, label: 'getAllRewards');
  }

  @override
  Future<List<RewardEntity>> getActiveRewards() async {
    return await safeCall(() async {
      final querySnapshot =
          await _rewardsCollection.where('is_active', isEqualTo: true).get();

      final rewards = querySnapshot.docs.map((doc) {
        final model = RewardModel.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
        return model.toEntity();
      }).toList();

      return rewards;
    }, label: 'getActiveRewards');
  }

  @override
  Future<RewardEntity?> getRewardById(String rewardId) async {
    return await safeCall(() async {
      final doc = await _rewardsCollection.doc(rewardId).get();
      if (!doc.exists) return null;

      final model = RewardModel.fromJson({
        'id': doc.id,
        ...doc.data()! as Map<String, dynamic>,
      });
      return model.toEntity();
    }, label: 'getRewardById');
  }

  @override
  Future<UserRedemptionEntity?> getRewardRedemptionById(
      String redemptionId) async {
    return await safeCall(() async {
      final doc = await _redemptionsCollection.doc(redemptionId).get();

      if (!doc.exists) return null;

      final model = UserRedemptionModel.fromJson({
        'id': doc.id,
        ...doc.data()! as Map<String, dynamic>,
      });
      return model.toEntity();
    }, label: 'getRewardRedemptionById');
  }

  @override
  Future<void> redeemReward(
      String userId, String rewardId, int pointsRequired) async {
    return await safeCall(() async {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(userId);
        final userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception('User not found');
        }

        final currentPoints = userSnapshot.data()?['total_points'] ?? 0;
        if (currentPoints < pointsRequired) {
          throw Exception('Not enough points');
        }

        final rewardDoc =
            await transaction.get(_rewardsCollection.doc(rewardId));
        if (!rewardDoc.exists) {
          throw Exception('Reward not found');
        }

        final rewardData = rewardDoc.data() as Map<String, dynamic>;
        if (!(rewardData['is_active'] ?? true)) {
          throw Exception('Reward is no longer active');
        }

        final currentRedeemedRewards =
            List<String>.from(userSnapshot.data()?['redeemed_rewards'] ?? []);
        currentRedeemedRewards.add(rewardId);

        transaction.update(userDoc, {
          'total_points': FieldValue.increment(-pointsRequired),
          'redeemed_rewards': currentRedeemedRewards,
        });

        final redemptionId = DateTime.now().millisecondsSinceEpoch.toString();
        final redemptionModel = UserRedemptionModel(
          id: redemptionId,
          userId: userId,
          rewardId: rewardId,
          rewardName: rewardData['name'],
          rewardDescription: rewardData['description'] ?? '',
          pointsUsed: pointsRequired,
          redeemedAt: DateTime.now(),
          isUsed: false,
          qrCode: 'QR_${redemptionId}',
          usedAt: null,
          usedByStaff: null,
          expiryDate: DateTime.now().add(const Duration(days: 7)),
          imageUrl: rewardData['image_url'] ?? '',
        );

        transaction.set(
          _redemptionsCollection.doc(redemptionId),
          redemptionModel.toJson(),
        );
      });
    }, label: 'redeemReward');
  }

  @override
  Future<List<UserRedemptionEntity>> getUserRedemptions(String userId) async {
    return await safeCall(() async {
      final querySnapshot = await _redemptionsCollection
          .where('user_id', isEqualTo: userId)
          .orderBy('redeemed_at', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final model =
            UserRedemptionModel.fromJson(doc.data() as Map<String, dynamic>);
        return model.toEntity();
      }).toList();
    }, label: 'getUserRedemptions');
  }

  @override
  Future<void> markRedemptionAsUsed(String redemptionId, String staffId) async {
    return await safeCall(() async {
      await _redemptionsCollection.doc(redemptionId).update({
        'is_used': true,
        'used_at': FieldValue.serverTimestamp(),
        'used_by_staff': staffId,
      });
    }, label: 'markRedemptionAsUsed');
  }

  @override
  Future<bool> hasUserRedeemedReward(String userId, String rewardId) async {
    return await safeCall(() async {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) return false;

      final redeemedRewards =
          List<String>.from(userDoc.data()?['redeemed_rewards'] ?? []);
      return redeemedRewards.contains(rewardId);
    }, label: 'hasUserRedeemedReward');
  }
}
