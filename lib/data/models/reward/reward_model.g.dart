// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardModel _$RewardModelFromJson(Map<String, dynamic> json) => _RewardModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pointsRequired: (json['points_required'] as num?)?.toInt(),
      isActive: json['is_active'] as bool? ?? true,
      imageUrl: json['image_url'] as String?,
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
    );

Map<String, dynamic> _$RewardModelToJson(_RewardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'points_required': instance.pointsRequired,
      'is_active': instance.isActive,
      'image_url': instance.imageUrl,
      'expiry_date': instance.expiryDate?.toIso8601String(),
    };
