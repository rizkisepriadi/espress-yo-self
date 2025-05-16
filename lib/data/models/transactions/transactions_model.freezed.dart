// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionsModel {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'time_stamp')
  String get timeStamp;
  @JsonKey(name: 'points_earned')
  int get pointsEarned;

  /// Create a copy of TransactionsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionsModelCopyWith<TransactionsModel> get copyWith =>
      _$TransactionsModelCopyWithImpl<TransactionsModel>(
          this as TransactionsModel, _$identity);

  /// Serializes this TransactionsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, timeStamp, pointsEarned);

  @override
  String toString() {
    return 'TransactionsModel(id: $id, userId: $userId, timeStamp: $timeStamp, pointsEarned: $pointsEarned)';
  }
}

/// @nodoc
abstract mixin class $TransactionsModelCopyWith<$Res> {
  factory $TransactionsModelCopyWith(
          TransactionsModel value, $Res Function(TransactionsModel) _then) =
      _$TransactionsModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'time_stamp') String timeStamp,
      @JsonKey(name: 'points_earned') int pointsEarned});
}

/// @nodoc
class _$TransactionsModelCopyWithImpl<$Res>
    implements $TransactionsModelCopyWith<$Res> {
  _$TransactionsModelCopyWithImpl(this._self, this._then);

  final TransactionsModel _self;
  final $Res Function(TransactionsModel) _then;

  /// Create a copy of TransactionsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timeStamp = null,
    Object? pointsEarned = null,
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
      timeStamp: null == timeStamp
          ? _self.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _self.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionsModel implements TransactionsModel {
  const _TransactionsModel(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'time_stamp') required this.timeStamp,
      @JsonKey(name: 'points_earned') required this.pointsEarned});
  factory _TransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionsModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'time_stamp')
  final String timeStamp;
  @override
  @JsonKey(name: 'points_earned')
  final int pointsEarned;

  /// Create a copy of TransactionsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionsModelCopyWith<_TransactionsModel> get copyWith =>
      __$TransactionsModelCopyWithImpl<_TransactionsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, timeStamp, pointsEarned);

  @override
  String toString() {
    return 'TransactionsModel(id: $id, userId: $userId, timeStamp: $timeStamp, pointsEarned: $pointsEarned)';
  }
}

/// @nodoc
abstract mixin class _$TransactionsModelCopyWith<$Res>
    implements $TransactionsModelCopyWith<$Res> {
  factory _$TransactionsModelCopyWith(
          _TransactionsModel value, $Res Function(_TransactionsModel) _then) =
      __$TransactionsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'time_stamp') String timeStamp,
      @JsonKey(name: 'points_earned') int pointsEarned});
}

/// @nodoc
class __$TransactionsModelCopyWithImpl<$Res>
    implements _$TransactionsModelCopyWith<$Res> {
  __$TransactionsModelCopyWithImpl(this._self, this._then);

  final _TransactionsModel _self;
  final $Res Function(_TransactionsModel) _then;

  /// Create a copy of TransactionsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timeStamp = null,
    Object? pointsEarned = null,
  }) {
    return _then(_TransactionsModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timeStamp: null == timeStamp
          ? _self.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _self.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
