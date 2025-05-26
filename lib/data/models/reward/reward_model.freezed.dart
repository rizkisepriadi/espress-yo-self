// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardModel {
  String get id;
  String get name;
  String get description;
  @JsonKey(name: 'points_required')
  int get pointsRequired;
  @JsonKey(name: 'is_active')
  bool get isActive;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @JsonKey(name: 'expiry_date')
  DateTime? get expiryDate;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RewardModelCopyWith<RewardModel> get copyWith =>
      _$RewardModelCopyWithImpl<RewardModel>(this as RewardModel, _$identity);

  /// Serializes this RewardModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RewardModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pointsRequired, pointsRequired) ||
                other.pointsRequired == pointsRequired) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      pointsRequired, isActive, imageUrl, expiryDate);

  @override
  String toString() {
    return 'RewardModel(id: $id, name: $name, description: $description, pointsRequired: $pointsRequired, isActive: $isActive, imageUrl: $imageUrl, expiryDate: $expiryDate)';
  }
}

/// @nodoc
abstract mixin class $RewardModelCopyWith<$Res> {
  factory $RewardModelCopyWith(
          RewardModel value, $Res Function(RewardModel) _then) =
      _$RewardModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'points_required') int pointsRequired,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'expiry_date') DateTime? expiryDate});
}

/// @nodoc
class _$RewardModelCopyWithImpl<$Res> implements $RewardModelCopyWith<$Res> {
  _$RewardModelCopyWithImpl(this._self, this._then);

  final RewardModel _self;
  final $Res Function(RewardModel) _then;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? pointsRequired = null,
    Object? isActive = null,
    Object? imageUrl = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pointsRequired: null == pointsRequired
          ? _self.pointsRequired
          : pointsRequired // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _self.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RewardModel implements RewardModel {
  const _RewardModel(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'points_required') required this.pointsRequired,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'expiry_date') this.expiryDate});
  factory _RewardModel.fromJson(Map<String, dynamic> json) =>
      _$RewardModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'points_required')
  final int pointsRequired;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'expiry_date')
  final DateTime? expiryDate;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RewardModelCopyWith<_RewardModel> get copyWith =>
      __$RewardModelCopyWithImpl<_RewardModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RewardModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RewardModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pointsRequired, pointsRequired) ||
                other.pointsRequired == pointsRequired) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      pointsRequired, isActive, imageUrl, expiryDate);

  @override
  String toString() {
    return 'RewardModel(id: $id, name: $name, description: $description, pointsRequired: $pointsRequired, isActive: $isActive, imageUrl: $imageUrl, expiryDate: $expiryDate)';
  }
}

/// @nodoc
abstract mixin class _$RewardModelCopyWith<$Res>
    implements $RewardModelCopyWith<$Res> {
  factory _$RewardModelCopyWith(
          _RewardModel value, $Res Function(_RewardModel) _then) =
      __$RewardModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'points_required') int pointsRequired,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'expiry_date') DateTime? expiryDate});
}

/// @nodoc
class __$RewardModelCopyWithImpl<$Res> implements _$RewardModelCopyWith<$Res> {
  __$RewardModelCopyWithImpl(this._self, this._then);

  final _RewardModel _self;
  final $Res Function(_RewardModel) _then;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? pointsRequired = null,
    Object? isActive = null,
    Object? imageUrl = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_RewardModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pointsRequired: null == pointsRequired
          ? _self.pointsRequired
          : pointsRequired // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _self.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
