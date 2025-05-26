class RewardEntity {
  final String id;
  final String name;
  final String description;
  final int pointsRequired;
  final bool isActive;
  final String? imageUrl;
  final DateTime? expiryDate;

  const RewardEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsRequired,
    this.isActive = true,
    this.imageUrl,
    this.expiryDate,
  });
}
