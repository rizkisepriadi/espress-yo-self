class TransactionsEntitty {
  final String id;
  final String userId;
  final String timeStamp;
  final int pointsEarned;
  final String transactionType;
  final String title; 
  final String description;
  final String? orderId; 
  final String? rewardId;
  final double? amount;

  const TransactionsEntitty({
    required this.id,
    required this.userId,
    required this.timeStamp,
    required this.pointsEarned,
    required this.transactionType,
    required this.title,
    required this.description,
    this.orderId,
    this.rewardId,
    this.amount,
  });
}
