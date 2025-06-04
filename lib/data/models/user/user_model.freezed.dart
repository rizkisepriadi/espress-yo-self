// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {
  String get id;
  String get name;
  String get email;
  @JsonKey(name: 'total_points')
  int get totalPoints;
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl;
  @JsonKey(name: 'redeemed_rewards')
  List<String> get redeemedRewards;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<UserModel> get copyWith =>
      _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality()
                .equals(other.redeemedRewards, redeemedRewards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, totalPoints,
      profileImageUrl, const DeepCollectionEquality().hash(redeemedRewards));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, totalPoints: $totalPoints, profileImageUrl: $profileImageUrl, redeemedRewards: $redeemedRewards)';
  }
}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) =
      _$UserModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @JsonKey(name: 'total_points') int totalPoints,
      @JsonKey(name: 'profile_image_url') String? profileImageUrl,
      @JsonKey(name: 'redeemed_rewards') List<String> redeemedRewards});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? totalPoints = null,
    Object? profileImageUrl = freezed,
    Object? redeemedRewards = null,
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
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      totalPoints: null == totalPoints
          ? _self.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      profileImageUrl: freezed == profileImageUrl
          ? _self.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      redeemedRewards: null == redeemedRewards
          ? _self.redeemedRewards
          : redeemedRewards // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserModel implements UserModel {
  const _UserModel(
      {required this.id,
      required this.name,
      required this.email,
      @JsonKey(name: 'total_points') required this.totalPoints,
      @JsonKey(name: 'profile_image_url') required this.profileImageUrl,
      @JsonKey(name: 'redeemed_rewards')
      required final List<String> redeemedRewards})
      : _redeemedRewards = redeemedRewards;
  factory _UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'total_points')
  final int totalPoints;
  @override
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  final List<String> _redeemedRewards;
  @override
  @JsonKey(name: 'redeemed_rewards')
  List<String> get redeemedRewards {
    if (_redeemedRewards is EqualUnmodifiableListView) return _redeemedRewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_redeemedRewards);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._redeemedRewards, _redeemedRewards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, totalPoints,
      profileImageUrl, const DeepCollectionEquality().hash(_redeemedRewards));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, totalPoints: $totalPoints, profileImageUrl: $profileImageUrl, redeemedRewards: $redeemedRewards)';
  }
}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) _then) =
      __$UserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @JsonKey(name: 'total_points') int totalPoints,
      @JsonKey(name: 'profile_image_url') String? profileImageUrl,
      @JsonKey(name: 'redeemed_rewards') List<String> redeemedRewards});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? totalPoints = null,
    Object? profileImageUrl = freezed,
    Object? redeemedRewards = null,
  }) {
    return _then(_UserModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      totalPoints: null == totalPoints
          ? _self.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      profileImageUrl: freezed == profileImageUrl
          ? _self.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      redeemedRewards: null == redeemedRewards
          ? _self._redeemedRewards
          : redeemedRewards // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
