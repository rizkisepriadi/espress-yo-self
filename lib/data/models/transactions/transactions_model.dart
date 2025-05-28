import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_model.freezed.dart';
part 'transactions_model.g.dart';

@freezed
abstract class TransactionsModel with _$TransactionsModel {
  const factory TransactionsModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'time_stamp') required String timeStamp,
    @JsonKey(name: 'points_earned') required int pointsEarned,
    @JsonKey(name: 'transaction_type') required String transactionType,
    required String title,
    required String description,
    @JsonKey(name: 'order_id') String? orderId,
    @JsonKey(name: 'reward_id') String? rewardId,
    double? amount,
    @JsonKey(name: 'is_eco_friendly') @Default(false) bool isEcoFriendly,
    @JsonKey(name: 'eco_points_bonus') @Default(0) int ecoPointsBonus,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'image_250_url') String? image250Url,
  }) = _TransactionsModel;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionsModelFromJson(json);
}

extension TransactionsModelMapper on TransactionsModel {
  TransactionsEntitty toEntity() => TransactionsEntitty(
        id: id,
        userId: userId,
        timeStamp: timeStamp,
        pointsEarned: pointsEarned,
        transactionType: transactionType,
        title: title,
        description: description,
        orderId: orderId,
        rewardId: rewardId,
        amount: amount,
        isEcoFriendly: isEcoFriendly,
        ecoPointsBonus: ecoPointsBonus,
        imageUrl: imageUrl,
        image250Url: image250Url,
      );

  static TransactionsModel fromEntity(TransactionsEntitty entity) =>
      TransactionsModel(
        id: entity.id,
        userId: entity.userId,
        timeStamp: entity.timeStamp,
        pointsEarned: entity.pointsEarned,
        transactionType: entity.transactionType,
        title: entity.title,
        description: entity.description,
        orderId: entity.orderId,
        rewardId: entity.rewardId,
        amount: entity.amount,
        isEcoFriendly: entity.isEcoFriendly,
        ecoPointsBonus: entity.ecoPointsBonus,
        imageUrl: entity.imageUrl,
        image250Url: entity.image250Url,
      );
}
