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
    };
