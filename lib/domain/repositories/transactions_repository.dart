import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';

abstract class TransactionsRepository {
  Future<TransactionsEntitty> getTransactions();
  Future<void> addTransaction(String userId, int points);
}
