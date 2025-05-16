import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamp_progress_model.freezed.dart';
part 'stamp_progress_model.g.dart';

@freezed
abstract class StampProgressModel with _$StampProgressModel {
  const factory StampProgressModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'stamps_collected') required int stampsCollected,
    @JsonKey(name: 'stamps_required') required int stampsRequired,
  }) = _StampProgressModel;

  factory StampProgressModel.fromJson(Map<String, dynamic> json) =>
      _$StampProgressModelFromJson(json);
}

extension StampProgressModelMapper on StampProgressModel {
  StampProgressEntity toEntity() => StampProgressEntity(
      userId: userId,
      stampsCollected: stampsCollected,
      stampsRequired: stampsRequired);

  static StampProgressModel fromEntity(StampProgressEntity entity) =>
      StampProgressModel(
          userId: entity.userId,
          stampsCollected: entity.stampsCollected,
          stampsRequired: entity.stampsRequired);
}
