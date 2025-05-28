import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/repositories/transactions_repository.dart';

class AddTransactionUsecase {
  final TransactionsRepository repository;
  AddTransactionUsecase(this.repository);

  Future<void> call(String userId, int points) async {
    return await repository.addTransaction(userId, points);
  }
}

class AddTransactionFromQRUsecase {
  final TransactionsRepository repository;
  AddTransactionFromQRUsecase(this.repository);

  Future<void> call({
    required String userId,
    required String qrData,
  }) async {
    return await repository.addTransactionFromQR(
      userId: userId,
      qrData: qrData,
    );
  }
}

class AddDetailedTransactionUsecase {
  final TransactionsRepository repository;
  AddDetailedTransactionUsecase(this.repository);

  Future<void> call({
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
  }) async {
    return await repository.addDetailedTransaction(
      userId: userId,
      points: points,
      transactionType: transactionType,
      title: title,
      description: description,
      orderId: orderId,
      rewardId: rewardId,
      amount: amount,
      imageUrl: imageUrl,
      image250Url: image250Url,
      isEcoFriendly: isEcoFriendly,
      ecoPointsBonus: ecoPointsBonus,
    );
  }
}

class GetUserTransactionsUsecase {
  final TransactionsRepository repository;
  GetUserTransactionsUsecase(this.repository);

  Future<List<TransactionsEntitty>> call(String userId) async {
    return await repository.getUserTransactions(userId);
  }
}

class GetTransactionsUsecase {
  final TransactionsRepository repository;
  GetTransactionsUsecase(this.repository);

  Future<TransactionsEntitty> call() async {
    return await repository.getTransactions();
  }
}
