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
        'transaction_type': 'manual',
        'title': 'Points Added',
        'description': 'Manual points addition',
      });
    }, label: 'addTransaction');
  }

  @override
  Future<void> addDetailedTransaction({
    required String userId,
    required int points,
    required String transactionType,
    required String title,
    required String description,
    String? orderId,
    String? rewardId,
    double? amount,
  }) {
    return safeCall(() async {
      final docRef = _firestore.collection(_collection).doc();
      await docRef.set({
        'id': docRef.id,
        'user_id': userId,
        'time_stamp': DateTime.now().toIso8601String(),
        'points_earned': points,
        'transaction_type': transactionType,
        'title': title,
        'description': description,
        'order_id': orderId,
        'reward_id': rewardId,
        'amount': amount,
      });
    }, label: 'addDetailedTransaction');
  }

  @override
  Future<List<TransactionsEntitty>> getUserTransactions(String userId) {
    return safeCall(() async {
      final query = await _firestore
          .collection(_collection)
          .where('user_id', isEqualTo: userId)
          .orderBy('time_stamp', descending: true)
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        return TransactionsModel.fromJson(data).toEntity();
      }).toList();
    }, label: 'getUserTransactions');
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
}
