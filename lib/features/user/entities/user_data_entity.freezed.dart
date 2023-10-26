// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDataEntity _$UserDataEntityFromJson(Map<String, dynamic> json) {
  return _UserDataEntity.fromJson(json);
}

/// @nodoc
mixin _$UserDataEntity {
  String get uid => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  List<String> get interestedJobGroupIdList =>
      throw _privateConstructorUsedError;
  List<String> get techSkillIdList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataEntityCopyWith<UserDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataEntityCopyWith<$Res> {
  factory $UserDataEntityCopyWith(
          UserDataEntity value, $Res Function(UserDataEntity) then) =
      _$UserDataEntityCopyWithImpl<$Res, UserDataEntity>;
  @useResult
  $Res call(
      {String uid,
      String? nickname,
      List<String> interestedJobGroupIdList,
      List<String> techSkillIdList});
}

/// @nodoc
class _$UserDataEntityCopyWithImpl<$Res, $Val extends UserDataEntity>
    implements $UserDataEntityCopyWith<$Res> {
  _$UserDataEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? nickname = freezed,
    Object? interestedJobGroupIdList = null,
    Object? techSkillIdList = null,
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
      interestedJobGroupIdList: null == interestedJobGroupIdList
          ? _value.interestedJobGroupIdList
          : interestedJobGroupIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techSkillIdList: null == techSkillIdList
          ? _value.techSkillIdList
          : techSkillIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataEntityImplCopyWith<$Res>
    implements $UserDataEntityCopyWith<$Res> {
  factory _$$UserDataEntityImplCopyWith(_$UserDataEntityImpl value,
          $Res Function(_$UserDataEntityImpl) then) =
      __$$UserDataEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String? nickname,
      List<String> interestedJobGroupIdList,
      List<String> techSkillIdList});
}

/// @nodoc
class __$$UserDataEntityImplCopyWithImpl<$Res>
    extends _$UserDataEntityCopyWithImpl<$Res, _$UserDataEntityImpl>
    implements _$$UserDataEntityImplCopyWith<$Res> {
  __$$UserDataEntityImplCopyWithImpl(
      _$UserDataEntityImpl _value, $Res Function(_$UserDataEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? nickname = freezed,
    Object? interestedJobGroupIdList = null,
    Object? techSkillIdList = null,
  }) {
    return _then(_$UserDataEntityImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      interestedJobGroupIdList: null == interestedJobGroupIdList
          ? _value._interestedJobGroupIdList
          : interestedJobGroupIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techSkillIdList: null == techSkillIdList
          ? _value._techSkillIdList
          : techSkillIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataEntityImpl extends _UserDataEntity {
  const _$UserDataEntityImpl(
      {required this.uid,
      this.nickname,
      final List<String> interestedJobGroupIdList = const [],
      final List<String> techSkillIdList = const []})
      : _interestedJobGroupIdList = interestedJobGroupIdList,
        _techSkillIdList = techSkillIdList,
        super._();

  factory _$UserDataEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataEntityImplFromJson(json);

  @override
  final String uid;
  @override
  final String? nickname;
  final List<String> _interestedJobGroupIdList;
  @override
  @JsonKey()
  List<String> get interestedJobGroupIdList {
    if (_interestedJobGroupIdList is EqualUnmodifiableListView)
      return _interestedJobGroupIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interestedJobGroupIdList);
  }

  final List<String> _techSkillIdList;
  @override
  @JsonKey()
  List<String> get techSkillIdList {
    if (_techSkillIdList is EqualUnmodifiableListView) return _techSkillIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techSkillIdList);
  }

  @override
  String toString() {
    return 'UserDataEntity(uid: $uid, nickname: $nickname, interestedJobGroupIdList: $interestedJobGroupIdList, techSkillIdList: $techSkillIdList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataEntityImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality().equals(
                other._interestedJobGroupIdList, _interestedJobGroupIdList) &&
            const DeepCollectionEquality()
                .equals(other._techSkillIdList, _techSkillIdList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      nickname,
      const DeepCollectionEquality().hash(_interestedJobGroupIdList),
      const DeepCollectionEquality().hash(_techSkillIdList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataEntityImplCopyWith<_$UserDataEntityImpl> get copyWith =>
      __$$UserDataEntityImplCopyWithImpl<_$UserDataEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataEntityImplToJson(
      this,
    );
  }
}

abstract class _UserDataEntity extends UserDataEntity {
  const factory _UserDataEntity(
      {required final String uid,
      final String? nickname,
      final List<String> interestedJobGroupIdList,
      final List<String> techSkillIdList}) = _$UserDataEntityImpl;
  const _UserDataEntity._() : super._();

  factory _UserDataEntity.fromJson(Map<String, dynamic> json) =
      _$UserDataEntityImpl.fromJson;

  @override
  String get uid;
  @override
  String? get nickname;
  @override
  List<String> get interestedJobGroupIdList;
  @override
  List<String> get techSkillIdList;
  @override
  @JsonKey(ignore: true)
  _$$UserDataEntityImplCopyWith<_$UserDataEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
