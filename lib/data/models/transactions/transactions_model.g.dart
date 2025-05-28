// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionsModel _$TransactionsModelFromJson(Map<String, dynamic> json) =>
    _TransactionsModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      timeStamp: json['time_stamp'] as String,
      pointsEarned: (json['points_earned'] as num).toInt(),
      transactionType: json['transaction_type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      orderId: json['order_id'] as String?,
      rewardId: json['reward_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      isEcoFriendly: json['is_eco_friendly'] as bool? ?? false,
      ecoPointsBonus: (json['eco_points_bonus'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url'] as String?,
      image250Url: json['image_250_url'] as String?,
    );

Map<String, dynamic> _$TransactionsModelToJson(_TransactionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'time_stamp': instance.timeStamp,
      'points_earned': instance.pointsEarned,
      'transaction_type': instance.transactionType,
      'title': instance.title,
      'description': instance.description,
      'order_id': instance.orderId,
      'reward_id': instance.rewardId,
      'amount': instance.amount,
      'is_eco_friendly': instance.isEcoFriendly,
      'eco_points_bonus': instance.ecoPointsBonus,
      'image_url': instance.imageUrl,
      'image_250_url': instance.image250Url,
    };
