// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_redemption_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRedemptionModel {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'reward_id')
  String get rewardId;
  @JsonKey(name: 'reward_name')
  String get rewardName;
  @JsonKey(name: 'reward_description')
  String get rewardDescription;
  @JsonKey(name: 'points_used')
  int get pointsUsed;
  @JsonKey(name: 'redeemed_at')
  DateTime get redeemedAt;
  @JsonKey(name: 'is_used')
  bool get isUsed;
  @JsonKey(name: 'qr_code')
  String? get qrCode;
  @JsonKey(name: 'used_at')
  DateTime? get usedAt;
  @JsonKey(name: 'used_by_staff')
  String? get usedByStaff;

  /// Create a copy of UserRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserRedemptionModelCopyWith<UserRedemptionModel> get copyWith =>
      _$UserRedemptionModelCopyWithImpl<UserRedemptionModel>(
          this as UserRedemptionModel, _$identity);

  /// Serializes this UserRedemptionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserRedemptionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.rewardId, rewardId) ||
                other.rewardId == rewardId) &&
            (identical(other.rewardName, rewardName) ||
                other.rewardName == rewardName) &&
            (identical(other.rewardDescription, rewardDescription) ||
                other.rewardDescription == rewardDescription) &&
            (identical(other.pointsUsed, pointsUsed) ||
                other.pointsUsed == pointsUsed) &&
            (identical(other.redeemedAt, redeemedAt) ||
                other.redeemedAt == redeemedAt) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.usedAt, usedAt) || other.usedAt == usedAt) &&
            (identical(other.usedByStaff, usedByStaff) ||
                other.usedByStaff == usedByStaff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      rewardId,
      rewardName,
      rewardDescription,
      pointsUsed,
      redeemedAt,
      isUsed,
      qrCode,
      usedAt,
      usedByStaff);

  @override
  String toString() {
    return 'UserRedemptionModel(id: $id, userId: $userId, rewardId: $rewardId, rewardName: $rewardName, rewardDescription: $rewardDescription, pointsUsed: $pointsUsed, redeemedAt: $redeemedAt, isUsed: $isUsed, qrCode: $qrCode, usedAt: $usedAt, usedByStaff: $usedByStaff)';
  }
}

/// @nodoc
abstract mixin class $UserRedemptionModelCopyWith<$Res> {
  factory $UserRedemptionModelCopyWith(
          UserRedemptionModel value, $Res Function(UserRedemptionModel) _then) =
      _$UserRedemptionModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'reward_id') String rewardId,
      @JsonKey(name: 'reward_name') String rewardName,
      @JsonKey(name: 'reward_description') String rewardDescription,
      @JsonKey(name: 'points_used') int pointsUsed,
      @JsonKey(name: 'redeemed_at') DateTime redeemedAt,
      @JsonKey(name: 'is_used') bool isUsed,
      @JsonKey(name: 'qr_code') String? qrCode,
      @JsonKey(name: 'used_at') DateTime? usedAt,
      @JsonKey(name: 'used_by_staff') String? usedByStaff});
}

/// @nodoc
class _$UserRedemptionModelCopyWithImpl<$Res>
    implements $UserRedemptionModelCopyWith<$Res> {
  _$UserRedemptionModelCopyWithImpl(this._self, this._then);

  final UserRedemptionModel _self;
  final $Res Function(UserRedemptionModel) _then;

  /// Create a copy of UserRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? rewardId = null,
    Object? rewardName = null,
    Object? rewardDescription = null,
    Object? pointsUsed = null,
    Object? redeemedAt = null,
    Object? isUsed = null,
    Object? qrCode = freezed,
    Object? usedAt = freezed,
    Object? usedByStaff = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rewardId: null == rewardId
          ? _self.rewardId
          : rewardId // ignore: cast_nullable_to_non_nullable
              as String,
      rewardName: null == rewardName
          ? _self.rewardName
          : rewardName // ignore: cast_nullable_to_non_nullable
              as String,
      rewardDescription: null == rewardDescription
          ? _self.rewardDescription
          : rewardDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pointsUsed: null == pointsUsed
          ? _self.pointsUsed
          : pointsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      redeemedAt: null == redeemedAt
          ? _self.redeemedAt
          : redeemedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isUsed: null == isUsed
          ? _self.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as bool,
      qrCode: freezed == qrCode
          ? _self.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      usedAt: freezed == usedAt
          ? _self.usedAt
          : usedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      usedByStaff: freezed == usedByStaff
          ? _self.usedByStaff
          : usedByStaff // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserRedemptionModel implements UserRedemptionModel {
  const _UserRedemptionModel(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'reward_id') required this.rewardId,
      @JsonKey(name: 'reward_name') required this.rewardName,
      @JsonKey(name: 'reward_description') required this.rewardDescription,
      @JsonKey(name: 'points_used') required this.pointsUsed,
      @JsonKey(name: 'redeemed_at') required this.redeemedAt,
      @JsonKey(name: 'is_used') this.isUsed = false,
      @JsonKey(name: 'qr_code') this.qrCode,
      @JsonKey(name: 'used_at') this.usedAt,
      @JsonKey(name: 'used_by_staff') this.usedByStaff});
  factory _UserRedemptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserRedemptionModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'reward_id')
  final String rewardId;
  @override
  @JsonKey(name: 'reward_name')
  final String rewardName;
  @override
  @JsonKey(name: 'reward_description')
  final String rewardDescription;
  @override
  @JsonKey(name: 'points_used')
  final int pointsUsed;
  @override
  @JsonKey(name: 'redeemed_at')
  final DateTime redeemedAt;
  @override
  @JsonKey(name: 'is_used')
  final bool isUsed;
  @override
  @JsonKey(name: 'qr_code')
  final String? qrCode;
  @override
  @JsonKey(name: 'used_at')
  final DateTime? usedAt;
  @override
  @JsonKey(name: 'used_by_staff')
  final String? usedByStaff;

  /// Create a copy of UserRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserRedemptionModelCopyWith<_UserRedemptionModel> get copyWith =>
      __$UserRedemptionModelCopyWithImpl<_UserRedemptionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserRedemptionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserRedemptionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.rewardId, rewardId) ||
                other.rewardId == rewardId) &&
            (identical(other.rewardName, rewardName) ||
                other.rewardName == rewardName) &&
            (identical(other.rewardDescription, rewardDescription) ||
                other.rewardDescription == rewardDescription) &&
            (identical(other.pointsUsed, pointsUsed) ||
                other.pointsUsed == pointsUsed) &&
            (identical(other.redeemedAt, redeemedAt) ||
                other.redeemedAt == redeemedAt) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.usedAt, usedAt) || other.usedAt == usedAt) &&
            (identical(other.usedByStaff, usedByStaff) ||
                other.usedByStaff == usedByStaff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      rewardId,
      rewardName,
      rewardDescription,
      pointsUsed,
      redeemedAt,
      isUsed,
      qrCode,
      usedAt,
      usedByStaff);

  @override
  String toString() {
    return 'UserRedemptionModel(id: $id, userId: $userId, rewardId: $rewardId, rewardName: $rewardName, rewardDescription: $rewardDescription, pointsUsed: $pointsUsed, redeemedAt: $redeemedAt, isUsed: $isUsed, qrCode: $qrCode, usedAt: $usedAt, usedByStaff: $usedByStaff)';
  }
}

/// @nodoc
abstract mixin class _$UserRedemptionModelCopyWith<$Res>
    implements $UserRedemptionModelCopyWith<$Res> {
  factory _$UserRedemptionModelCopyWith(_UserRedemptionModel value,
          $Res Function(_UserRedemptionModel) _then) =
      __$UserRedemptionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'reward_id') String rewardId,
      @JsonKey(name: 'reward_name') String rewardName,
      @JsonKey(name: 'reward_description') String rewardDescription,
      @JsonKey(name: 'points_used') int pointsUsed,
      @JsonKey(name: 'redeemed_at') DateTime redeemedAt,
      @JsonKey(name: 'is_used') bool isUsed,
      @JsonKey(name: 'qr_code') String? qrCode,
      @JsonKey(name: 'used_at') DateTime? usedAt,
      @JsonKey(name: 'used_by_staff') String? usedByStaff});
}

/// @nodoc
class __$UserRedemptionModelCopyWithImpl<$Res>
    implements _$UserRedemptionModelCopyWith<$Res> {
  __$UserRedemptionModelCopyWithImpl(this._self, this._then);

  final _UserRedemptionModel _self;
  final $Res Function(_UserRedemptionModel) _then;

  /// Create a copy of UserRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? rewardId = null,
    Object? rewardName = null,
    Object? rewardDescription = null,
    Object? pointsUsed = null,
    Object? redeemedAt = null,
    Object? isUsed = null,
    Object? qrCode = freezed,
    Object? usedAt = freezed,
    Object? usedByStaff = freezed,
  }) {
    return _then(_UserRedemptionModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rewardId: null == rewardId
          ? _self.rewardId
          : rewardId // ignore: cast_nullable_to_non_nullable
              as String,
      rewardName: null == rewardName
          ? _self.rewardName
          : rewardName // ignore: cast_nullable_to_non_nullable
              as String,
      rewardDescription: null == rewardDescription
          ? _self.rewardDescription
          : rewardDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pointsUsed: null == pointsUsed
          ? _self.pointsUsed
          : pointsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      redeemedAt: null == redeemedAt
          ? _self.redeemedAt
          : redeemedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isUsed: null == isUsed
          ? _self.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as bool,
      qrCode: freezed == qrCode
          ? _self.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      usedAt: freezed == usedAt
          ? _self.usedAt
          : usedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      usedByStaff: freezed == usedByStaff
          ? _self.usedByStaff
          : usedByStaff // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
