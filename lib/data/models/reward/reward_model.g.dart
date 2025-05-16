// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardModel _$RewardModelFromJson(Map<String, dynamic> json) => _RewardModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pointsRequired: (json['points_required'] as num).toInt(),
      isClaimed: json['is_claimed'] as bool,
    );

Map<String, dynamic> _$RewardModelToJson(_RewardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'points_required': instance.pointsRequired,
      'is_claimed': instance.isClaimed,
    };
