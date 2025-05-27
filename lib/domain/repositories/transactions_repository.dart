import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';

abstract class TransactionsRepository {
  Future<TransactionsEntitty> getTransactions();
  Future<List<TransactionsEntitty>> getUserTransactions(String userId);
  Future<void> addTransaction(String userId, int points);

  Future<void> addDetailedTransaction({
    required String userId,
    required int points,
    required String transactionType,
    required String title,
    required String description,
    String? orderId,
    String? rewardId,
    double? amount,
  });
}
