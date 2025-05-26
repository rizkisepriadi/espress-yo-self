class StampProgressEntity {
  final String userId;
  final int stampsCollected;
  final int stampsRequired;
  final DateTime? lastUpdated;

  const StampProgressEntity({
    required this.userId,
    required this.stampsCollected,
    required this.stampsRequired,
    this.lastUpdated,
  });
}
