// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StampProgressModel {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'stamps_collected')
  int get stampsCollected;
  @JsonKey(name: 'stamps_required')
  int get stampsRequired;

  /// Create a copy of StampProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StampProgressModelCopyWith<StampProgressModel> get copyWith =>
      _$StampProgressModelCopyWithImpl<StampProgressModel>(
          this as StampProgressModel, _$identity);

  /// Serializes this StampProgressModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StampProgressModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.stampsCollected, stampsCollected) ||
                other.stampsCollected == stampsCollected) &&
            (identical(other.stampsRequired, stampsRequired) ||
                other.stampsRequired == stampsRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, stampsCollected, stampsRequired);

  @override
  String toString() {
    return 'StampProgressModel(userId: $userId, stampsCollected: $stampsCollected, stampsRequired: $stampsRequired)';
  }
}

/// @nodoc
abstract mixin class $StampProgressModelCopyWith<$Res> {
  factory $StampProgressModelCopyWith(
          StampProgressModel value, $Res Function(StampProgressModel) _then) =
      _$StampProgressModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'stamps_collected') int stampsCollected,
      @JsonKey(name: 'stamps_required') int stampsRequired});
}

/// @nodoc
class _$StampProgressModelCopyWithImpl<$Res>
    implements $StampProgressModelCopyWith<$Res> {
  _$StampProgressModelCopyWithImpl(this._self, this._then);

  final StampProgressModel _self;
  final $Res Function(StampProgressModel) _then;

  /// Create a copy of StampProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? stampsCollected = null,
    Object? stampsRequired = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      stampsCollected: null == stampsCollected
          ? _self.stampsCollected
          : stampsCollected // ignore: cast_nullable_to_non_nullable
              as int,
      stampsRequired: null == stampsRequired
          ? _self.stampsRequired
          : stampsRequired // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StampProgressModel implements StampProgressModel {
  const _StampProgressModel(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'stamps_collected') required this.stampsCollected,
      @JsonKey(name: 'stamps_required') required this.stampsRequired});
  factory _StampProgressModel.fromJson(Map<String, dynamic> json) =>
      _$StampProgressModelFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'stamps_collected')
  final int stampsCollected;
  @override
  @JsonKey(name: 'stamps_required')
  final int stampsRequired;

  /// Create a copy of StampProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StampProgressModelCopyWith<_StampProgressModel> get copyWith =>
      __$StampProgressModelCopyWithImpl<_StampProgressModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StampProgressModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StampProgressModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.stampsCollected, stampsCollected) ||
                other.stampsCollected == stampsCollected) &&
            (identical(other.stampsRequired, stampsRequired) ||
                other.stampsRequired == stampsRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, stampsCollected, stampsRequired);

  @override
  String toString() {
    return 'StampProgressModel(userId: $userId, stampsCollected: $stampsCollected, stampsRequired: $stampsRequired)';
  }
}

/// @nodoc
abstract mixin class _$StampProgressModelCopyWith<$Res>
    implements $StampProgressModelCopyWith<$Res> {
  factory _$StampProgressModelCopyWith(
          _StampProgressModel value, $Res Function(_StampProgressModel) _then) =
      __$StampProgressModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'stamps_collected') int stampsCollected,
      @JsonKey(name: 'stamps_required') int stampsRequired});
}

/// @nodoc
class __$StampProgressModelCopyWithImpl<$Res>
    implements _$StampProgressModelCopyWith<$Res> {
  __$StampProgressModelCopyWithImpl(this._self, this._then);

  final _StampProgressModel _self;
  final $Res Function(_StampProgressModel) _then;

  /// Create a copy of StampProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? stampsCollected = null,
    Object? stampsRequired = null,
  }) {
    return _then(_StampProgressModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      stampsCollected: null == stampsCollected
          ? _self.stampsCollected
          : stampsCollected // ignore: cast_nullable_to_non_nullable
              as int,
      stampsRequired: null == stampsRequired
          ? _self.stampsRequired
          : stampsRequired // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
