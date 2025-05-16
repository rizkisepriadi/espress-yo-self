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
  }) = _TransactionsModel;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionsModelFromJson(json);
}

extension TransactionsModelMapper on TransactionsModel {
  TransactionsEntitty toEntity() => TransactionsEntitty(
      id: id, userId: userId, timeStamp: timeStamp, pointsEarned: pointsEarned);

  static TransactionsModel fromEntity(TransactionsEntitty entity) =>
      TransactionsModel(
          id: entity.id,
          userId: entity.userId,
          timeStamp: entity.timeStamp,
          pointsEarned: entity.pointsEarned);
}
