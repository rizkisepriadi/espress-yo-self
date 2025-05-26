import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/usecases/transactions_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsViewmodel
    extends StateNotifier<AsyncValue<TransactionsEntitty>> {
  final GetUserTransactionsUsecase getTransactions;
  final AddTransactionUsecase addTransactionUsecase;

  TransactionsViewmodel({
    required this.getTransactions,
    required this.addTransactionUsecase,
  }) : super(const AsyncValue.loading()) {
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      final transactions = await getTransactions.call();
      if (!mounted) return;
      state = AsyncValue.data(transactions);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addTransaction(String userId, int points) async {
    try {
      await addTransactionUsecase.call(userId, points);
      if (!mounted) return;
      await fetchTransactions();
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }
}
