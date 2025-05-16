import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';

abstract class TransactionsRepository {
  Future<TransactionsEntitty> getTransactions();
  Future<void> addTransaction(String userId, int points);
  Future<void> redeemReward(String userId, String rewardId);
  Future<void> updateUserPoints(String userId, int points);
}
