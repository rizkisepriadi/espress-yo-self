import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel(
      {required String id,
      required String name,
      required String email,
      @JsonKey(name: 'total_points') required int totalPoints,
      @JsonKey(name: 'redeemed_rewards')
      required List<String> redeemedRewards}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelMapper on UserModel {
  UserEntity toEntity() => UserEntity(
      id: id,
      name: name,
      email: email,
      totalPoints: totalPoints,
      redeemedRewards: redeemedRewards);

  static UserModel fromEntity(UserEntity entity) => UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      totalPoints: entity.totalPoints,
      redeemedRewards: entity.redeemedRewards);
}
