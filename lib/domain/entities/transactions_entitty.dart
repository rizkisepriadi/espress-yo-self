class TransactionsEntitty {
  final String id;
  final String userId;
  final String timeStamp;
  final int pointsEarned;

  const TransactionsEntitty({
    required this.id,
    required this.userId,
    required this.timeStamp,
    required this.pointsEarned,
  });
}
