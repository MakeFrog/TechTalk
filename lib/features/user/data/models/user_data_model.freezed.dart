// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  return _UserDataModel.fromJson(json);
}

/// @nodoc
mixin _$UserDataModel {
  String get uid => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  List<String>? get interestedJobGroupIds => throw _privateConstructorUsedError;
  List<String>? get skillIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataModelCopyWith<UserDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataModelCopyWith<$Res> {
  factory $UserDataModelCopyWith(
          UserDataModel value, $Res Function(UserDataModel) then) =
      _$UserDataModelCopyWithImpl<$Res, UserDataModel>;
  @useResult
  $Res call(
      {String uid,
      String? nickname,
      List<String>? interestedJobGroupIds,
      List<String>? skillIds});
}

/// @nodoc
class _$UserDataModelCopyWithImpl<$Res, $Val extends UserDataModel>
    implements $UserDataModelCopyWith<$Res> {
  _$UserDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? nickname = freezed,
    Object? interestedJobGroupIds = freezed,
    Object? skillIds = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      interestedJobGroupIds: freezed == interestedJobGroupIds
          ? _value.interestedJobGroupIds
          : interestedJobGroupIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      skillIds: freezed == skillIds
          ? _value.skillIds
          : skillIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataModelImplCopyWith<$Res>
    implements $UserDataModelCopyWith<$Res> {
  factory _$$UserDataModelImplCopyWith(
          _$UserDataModelImpl value, $Res Function(_$UserDataModelImpl) then) =
      __$$UserDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String? nickname,
      List<String>? interestedJobGroupIds,
      List<String>? skillIds});
}

/// @nodoc
class __$$UserDataModelImplCopyWithImpl<$Res>
    extends _$UserDataModelCopyWithImpl<$Res, _$UserDataModelImpl>
    implements _$$UserDataModelImplCopyWith<$Res> {
  __$$UserDataModelImplCopyWithImpl(
      _$UserDataModelImpl _value, $Res Function(_$UserDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? nickname = freezed,
    Object? interestedJobGroupIds = freezed,
    Object? skillIds = freezed,
  }) {
    return _then(_$UserDataModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      interestedJobGroupIds: freezed == interestedJobGroupIds
          ? _value._interestedJobGroupIds
          : interestedJobGroupIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      skillIds: freezed == skillIds
          ? _value._skillIds
          : skillIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataModelImpl extends _UserDataModel {
  const _$UserDataModelImpl(
      {required this.uid,
      this.nickname,
      final List<String>? interestedJobGroupIds,
      final List<String>? skillIds})
      : _interestedJobGroupIds = interestedJobGroupIds,
        _skillIds = skillIds,
        super._();

  factory _$UserDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String? nickname;
  final List<String>? _interestedJobGroupIds;
  @override
  List<String>? get interestedJobGroupIds {
    final value = _interestedJobGroupIds;
    if (value == null) return null;
    if (_interestedJobGroupIds is EqualUnmodifiableListView)
      return _interestedJobGroupIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _skillIds;
  @override
  List<String>? get skillIds {
    final value = _skillIds;
    if (value == null) return null;
    if (_skillIds is EqualUnmodifiableListView) return _skillIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserDataModel(uid: $uid, nickname: $nickname, interestedJobGroupIds: $interestedJobGroupIds, skillIds: $skillIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality()
                .equals(other._interestedJobGroupIds, _interestedJobGroupIds) &&
            const DeepCollectionEquality().equals(other._skillIds, _skillIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      nickname,
      const DeepCollectionEquality().hash(_interestedJobGroupIds),
      const DeepCollectionEquality().hash(_skillIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataModelImplCopyWith<_$UserDataModelImpl> get copyWith =>
      __$$UserDataModelImplCopyWithImpl<_$UserDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataModelImplToJson(
      this,
    );
  }
}

abstract class _UserDataModel extends UserDataModel {
  const factory _UserDataModel(
      {required final String uid,
      final String? nickname,
      final List<String>? interestedJobGroupIds,
      final List<String>? skillIds}) = _$UserDataModelImpl;
  const _UserDataModel._() : super._();

  factory _UserDataModel.fromJson(Map<String, dynamic> json) =
      _$UserDataModelImpl.fromJson;

  @override
  String get uid;
  @override
  String? get nickname;
  @override
  List<String>? get interestedJobGroupIds;
  @override
  List<String>? get skillIds;
  @override
  @JsonKey(ignore: true)
  _$$UserDataModelImplCopyWith<_$UserDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
