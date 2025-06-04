class UserEntity {
  final String id;
  final String name;
  final String email;
  final int totalPoints;
  final String? profileImageUrl;
  final List<String> redeemedRewards;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.totalPoints,
    required this.redeemedRewards,
    this.profileImageUrl,
  });
}
