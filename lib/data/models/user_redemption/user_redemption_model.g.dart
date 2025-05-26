// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_redemption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRedemptionModel _$UserRedemptionModelFromJson(Map<String, dynamic> json) =>
    _UserRedemptionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      rewardId: json['reward_id'] as String,
      rewardName: json['reward_name'] as String,
      pointsUsed: (json['points_used'] as num).toInt(),
      redeemedAt: DateTime.parse(json['redeemed_at'] as String),
      isUsed: json['is_used'] as bool? ?? false,
      qrCode: json['qr_code'] as String?,
      usedAt: json['used_at'] == null
          ? null
          : DateTime.parse(json['used_at'] as String),
      usedByStaff: json['used_by_staff'] as String?,
    );

Map<String, dynamic> _$UserRedemptionModelToJson(
        _UserRedemptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'reward_id': instance.rewardId,
      'reward_name': instance.rewardName,
      'points_used': instance.pointsUsed,
      'redeemed_at': instance.redeemedAt.toIso8601String(),
      'is_used': instance.isUsed,
      'qr_code': instance.qrCode,
      'used_at': instance.usedAt?.toIso8601String(),
      'used_by_staff': instance.usedByStaff,
    };
