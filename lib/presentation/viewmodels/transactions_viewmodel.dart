import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/usecases/transactions_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsViewmodel
    extends StateNotifier<AsyncValue<List<TransactionsEntitty>>> {
  final GetUserTransactionsUsecase getUserTransactions;
  final AddTransactionUsecase addTransactionUsecase;
  final AddDetailedTransactionUsecase addDetailedTransactionUsecase;
  final AddTransactionFromQRUsecase addTransactionFromQRUsecase;

  TransactionsViewmodel({
    required this.getUserTransactions,
    required this.addTransactionUsecase,
    required this.addDetailedTransactionUsecase,
    required this.addTransactionFromQRUsecase,
  }) : super(const AsyncValue.loading());

  Future<void> fetchUserTransactions(String userId) async {
    try {
      state = const AsyncValue.loading();
      final transactions = await getUserTransactions.call(userId);
      if (!mounted) return;
      state = AsyncValue.data(transactions);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addTransactionFromQR({
    required String userId,
    required String qrData,
  }) async {
    try {
      await addTransactionFromQRUsecase.call(
        userId: userId,
        qrData: qrData,
      );
      if (!mounted) return;
      await fetchUserTransactions(userId);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addCoffeePurchaseTransaction({
    required String userId,
    required String coffeeName,
    required double amount,
    required int pointsEarned,
    String? orderId,
  }) async {
    try {
      await addDetailedTransactionUsecase.call(
        userId: userId,
        points: pointsEarned,
        transactionType: 'purchase',
        title: 'Coffee Purchase',
        description: coffeeName,
        orderId: orderId,
        amount: amount,
      );
      if (!mounted) return;
      await fetchUserTransactions(userId);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addRewardRedemptionTransaction({
    required String userId,
    required String rewardName,
    required int pointsUsed,
    String? rewardId,
  }) async {
    try {
      await addDetailedTransactionUsecase.call(
        userId: userId,
        points: -pointsUsed,
        transactionType: 'reward_redeem',
        title: 'Reward Redeemed',
        description: rewardName,
        rewardId: rewardId,
      );
      if (!mounted) return;
      await fetchUserTransactions(userId);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }
}
