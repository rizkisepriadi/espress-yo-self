// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StampProgressModel _$StampProgressModelFromJson(Map<String, dynamic> json) =>
    _StampProgressModel(
      userId: json['user_id'] as String,
      stampsCollected: (json['stamps_collected'] as num).toInt(),
      stampsRequired: (json['stamps_required'] as num).toInt(),
    );

Map<String, dynamic> _$StampProgressModelToJson(_StampProgressModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'stamps_collected': instance.stampsCollected,
      'stamps_required': instance.stampsRequired,
    };
