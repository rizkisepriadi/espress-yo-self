import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/repositories/transactions_repository.dart';

class AddTransactionUsecase {
  final TransactionsRepository repository;
  AddTransactionUsecase(this.repository);
  Future<void> call(String userId, int points) async {
    return await repository.addTransaction(userId, points);
  }
}

class GetUserTransactionsUsecase {
  final TransactionsRepository repository;
  GetUserTransactionsUsecase(this.repository);
  Future<TransactionsEntitty> call() async {
    return await repository.getTransactions();
  }
}