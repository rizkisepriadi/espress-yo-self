class RewardEntity {
  final String id;
  final String name;
  final String description;
  final int pointsRequired;
  final bool isClaimed;

  const RewardEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.isClaimed,
  });
}
