import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/data/services/auth_service.dart';
import 'package:espress_yo_self/domain/entities/user_entity.dart';
import 'package:espress_yo_self/domain/repositories/user_repository.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

import '../models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;
  final AuthService authService;

  UserRepositoryImpl({required this.firestore, required this.authService});

  @override
  Future<UserEntity> getCurrentUser() async {
    return await safeCall(() async {
      final user = authService.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final doc = await firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!).toEntity();
      } else {
        throw Exception('User not found');
      }
    }, label: 'getCurrentUser');
  }

  @override
  Future<void> updateUserPoints(String userId, int newPoints) async {
    return await safeCall(() async {
      await firestore
          .collection('users')
          .doc(userId)
          .update({'total_points': newPoints});
    }, label: 'updateUserPoints');
  }

  @override
  Future<void> redeemReward(String userId, String rewardId) async {
    return await safeCall(() async {
      final userDoc = firestore.collection('users').doc(userId);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        throw Exception('User not found');
      }

      final userData = userSnapshot.data()!;
      final redeemedRewards =
          List<String>.from(userData['redeemed_rewards'] ?? []);
      if (redeemedRewards.contains(rewardId)) {
        throw Exception('Reward already redeemed');
      }

      redeemedRewards.add(rewardId);
      await userDoc.update({'redeemed_rewards': redeemedRewards});
    }, label: 'redeemReward');
  }

  @override
  Future<void> updateStampProgress(String userId, int stamps) async {
    return await safeCall(() async {
      final userDoc = firestore.collection('users').doc(userId);
      await userDoc.update({'stamp_progress': stamps});
    }, label: 'updateStampProgress');
  }

  @override
  Future<void> updateUserProfile(String userId, String name) async {
    return safeCall(() async {
      final userDocRef = firestore.collection('users').doc(userId);

      final docSnapshot = await userDocRef.get();

      if (!docSnapshot.exists) {
        await userDocRef.set({
          'id': userId,
          'name': name,
          'email': authService.currentUser?.email ?? '',
          'total_points': 0,
          'redeemed_rewards': []
        });
      } else {
        await userDocRef.update({'name': name});
      }
    }, label: 'updateUserProfile');
  }
}
