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
    String? imageUrl,
    String? image250Url,
    bool isEcoFriendly = false,
    int ecoPointsBonus = 0,
  });

  Future<void> addTransactionFromQR({
    required String userId,
    required String qrData,
  });
}
