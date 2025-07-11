// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      totalPoints: (json['total_points'] as num).toInt(),
      profileImageUrl: json['profile_image_url'] as String?,
      redeemedRewards: (json['redeemed_rewards'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'total_points': instance.totalPoints,
      'profile_image_url': instance.profileImageUrl,
      'redeemed_rewards': instance.redeemedRewards,
    };
