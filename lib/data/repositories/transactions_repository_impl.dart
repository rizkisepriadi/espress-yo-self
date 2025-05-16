import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/repositories/transactions_repository.dart';
import 'package:espress_yo_self/data/models/transactions/transactions_model.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'transactions';

  @override
  Future<void> addTransaction(String userId, int points) {
    return safeCall(() async {
      final docRef = _firestore.collection(_collection).doc();
      await docRef.set({
        'id': docRef.id,
        'user_id': userId,
        'time_stamp': DateTime.now().toIso8601String(),
        'points_earned': points,
      });
    }, label: 'addTransaction');
  }

  @override
  Future<TransactionsEntitty> getTransactions() {
    return safeCall(() async {
      final query = await _firestore.collection(_collection).limit(1).get();
      if (query.docs.isEmpty) {
        throw Exception('No transactions found');
      }
      final data = query.docs.first.data();
      final model = TransactionsModel.fromJson(data);
      return model.toEntity();
    }, label: 'getTransactions');
  }

  @override
  Future<void> redeemReward(String userId, String rewardId) {
    return safeCall(() async {
      await _firestore.collection('users').doc(userId).update({
        'reward_redeemed': FieldValue.arrayUnion([rewardId])
      });
    }, label: 'redeemReward');
  }

  @override
  Future<void> updateUserPoints(String userId, int points) {
    return safeCall(() async {
      await _firestore.collection('users').doc(userId).update({
        'points': points,
      });
    }, label: 'updateUserPoints');
  }
}
