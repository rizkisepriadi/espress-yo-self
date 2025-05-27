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
  @JsonKey(name: 'transaction_type')
  String get transactionType;
  String get title;
  String get description;
  @JsonKey(name: 'order_id')
  String? get orderId;
  @JsonKey(name: 'reward_id')
  String? get rewardId;
  double? get amount;

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
                other.pointsEarned == pointsEarned) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.rewardId, rewardId) ||
                other.rewardId == rewardId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      timeStamp,
      pointsEarned,
      transactionType,
      title,
      description,
      orderId,
      rewardId,
      amount);

  @override
  String toString() {
    return 'TransactionsModel(id: $id, userId: $userId, timeStamp: $timeStamp, pointsEarned: $pointsEarned, transactionType: $transactionType, title: $title, description: $description, orderId: $orderId, rewardId: $rewardId, amount: $amount)';
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
      @JsonKey(name: 'points_earned') int pointsEarned,
      @JsonKey(name: 'transaction_type') String transactionType,
      String title,
      String description,
      @JsonKey(name: 'order_id') String? orderId,
      @JsonKey(name: 'reward_id') String? rewardId,
      double? amount});
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
    Object? transactionType = null,
    Object? title = null,
    Object? description = null,
    Object? orderId = freezed,
    Object? rewardId = freezed,
    Object? amount = freezed,
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
      transactionType: null == transactionType
          ? _self.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: freezed == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardId: freezed == rewardId
          ? _self.rewardId
          : rewardId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
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
      @JsonKey(name: 'points_earned') required this.pointsEarned,
      @JsonKey(name: 'transaction_type') required this.transactionType,
      required this.title,
      required this.description,
      @JsonKey(name: 'order_id') this.orderId,
      @JsonKey(name: 'reward_id') this.rewardId,
      this.amount});
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
  @override
  @JsonKey(name: 'transaction_type')
  final String transactionType;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'order_id')
  final String? orderId;
  @override
  @JsonKey(name: 'reward_id')
  final String? rewardId;
  @override
  final double? amount;

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
                other.pointsEarned == pointsEarned) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.rewardId, rewardId) ||
                other.rewardId == rewardId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      timeStamp,
      pointsEarned,
      transactionType,
      title,
      description,
      orderId,
      rewardId,
      amount);

  @override
  String toString() {
    return 'TransactionsModel(id: $id, userId: $userId, timeStamp: $timeStamp, pointsEarned: $pointsEarned, transactionType: $transactionType, title: $title, description: $description, orderId: $orderId, rewardId: $rewardId, amount: $amount)';
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
      @JsonKey(name: 'points_earned') int pointsEarned,
      @JsonKey(name: 'transaction_type') String transactionType,
      String title,
      String description,
      @JsonKey(name: 'order_id') String? orderId,
      @JsonKey(name: 'reward_id') String? rewardId,
      double? amount});
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
    Object? transactionType = null,
    Object? title = null,
    Object? description = null,
    Object? orderId = freezed,
    Object? rewardId = freezed,
    Object? amount = freezed,
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
      transactionType: null == transactionType
          ? _self.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: freezed == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardId: freezed == rewardId
          ? _self.rewardId
          : rewardId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
