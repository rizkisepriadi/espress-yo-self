import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:espress_yo_self/domain/entities/user_redemption_entity.dart';

part 'user_redemption_model.freezed.dart';
part 'user_redemption_model.g.dart';

@freezed
abstract class UserRedemptionModel with _$UserRedemptionModel {
  const factory UserRedemptionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'reward_id') required String rewardId,
    @JsonKey(name: 'reward_name') required String rewardName,
    @JsonKey(name: 'reward_description') required String rewardDescription,
    @JsonKey(name: 'points_used') required int pointsUsed,
    @JsonKey(name: 'redeemed_at') required DateTime redeemedAt,
    @JsonKey(name: 'is_used') @Default(false) bool isUsed,
    @JsonKey(name: 'qr_code') String? qrCode,
    @JsonKey(name: 'used_at') DateTime? usedAt,
    @JsonKey(name: 'used_by_staff') String? usedByStaff,
    @JsonKey(name: 'expiry_date') DateTime? expiryDate,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _UserRedemptionModel;

  factory UserRedemptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserRedemptionModelFromJson(json);
}

extension UserRedemptionModelMapper on UserRedemptionModel {
  UserRedemptionEntity toEntity() => UserRedemptionEntity(
        id: id,
        userId: userId,
        rewardId: rewardId,
        rewardName: rewardName,
        rewardDescription: rewardDescription,
        pointsUsed: pointsUsed,
        redeemedAt: redeemedAt,
        isUsed: isUsed,
        qrCode: qrCode,
        usedAt: usedAt,
        usedByStaff: usedByStaff,
        expiryDate: expiryDate,
        imageUrl: imageUrl,
      );

  static UserRedemptionModel fromEntity(UserRedemptionEntity entity) =>
      UserRedemptionModel(
        id: entity.id,
        userId: entity.userId,
        rewardId: entity.rewardId,
        rewardName: entity.rewardName,
        rewardDescription: entity.rewardDescription,
        pointsUsed: entity.pointsUsed,
        redeemedAt: entity.redeemedAt,
        isUsed: entity.isUsed,
        qrCode: entity.qrCode,
        usedAt: entity.usedAt,
        usedByStaff: entity.usedByStaff,
        expiryDate: entity.expiryDate,
        imageUrl: entity.imageUrl,
      );
}
