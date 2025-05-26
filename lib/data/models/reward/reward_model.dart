import 'package:espress_yo_self/domain/entities/reward_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_model.freezed.dart';
part 'reward_model.g.dart';

@freezed
abstract class RewardModel with _$RewardModel {
  const factory RewardModel({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'points_required') required int pointsRequired,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'expiry_date') DateTime? expiryDate,
  }) = _RewardModel;

  factory RewardModel.fromJson(Map<String, dynamic> json) =>
      _$RewardModelFromJson(json);
}

extension RewardModelMapper on RewardModel {
  RewardEntity toEntity() => RewardEntity(
    id: id,
    name: name,
    description: description,
    pointsRequired: pointsRequired,
    isActive: isActive,
    imageUrl: imageUrl,
    expiryDate: expiryDate,
  );

  static RewardModel fromEntity(RewardEntity entity) => RewardModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    pointsRequired: entity.pointsRequired,
    isActive: entity.isActive,
    imageUrl: entity.imageUrl,
    expiryDate: entity.expiryDate,
  );
}
