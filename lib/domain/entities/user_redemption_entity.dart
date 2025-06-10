class UserRedemptionEntity {
  final String id;
  final String userId;
  final String rewardId;
  final String rewardName;
  final String rewardDescription;
  final int pointsUsed;
  final DateTime redeemedAt;
  final bool isUsed; 
  final String? qrCode;
  final DateTime? usedAt; 
  final String? usedByStaff;
  final DateTime? expiryDate;
  final String? imageUrl;  

  const UserRedemptionEntity({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.rewardName,
    required this.rewardDescription,
    required this.pointsUsed,
    required this.redeemedAt,
    this.isUsed = false,
    this.qrCode,
    this.usedAt,
    this.usedByStaff,
    this.expiryDate,
    this.imageUrl,
  });
}