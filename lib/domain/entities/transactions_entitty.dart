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
  final bool isEcoFriendly;
  final int ecoPointsBonus;
  final String? imageUrl;
  final String? image250Url;

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
    this.isEcoFriendly = false,
    this.ecoPointsBonus = 0,
    this.imageUrl,
    this.image250Url,
  });
}
