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
  List<String>? get interestedJobGroupIdList =>
      throw _privateConstructorUsedError;
  List<String>? get techSkillIdList => throw _privateConstructorUsedError;

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
      List<String>? interestedJobGroupIdList,
      List<String>? techSkillIdList});
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
    Object? interestedJobGroupIdList = freezed,
    Object? techSkillIdList = freezed,
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
      interestedJobGroupIdList: freezed == interestedJobGroupIdList
          ? _value.interestedJobGroupIdList
          : interestedJobGroupIdList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      techSkillIdList: freezed == techSkillIdList
          ? _value.techSkillIdList
          : techSkillIdList // ignore: cast_nullable_to_non_nullable
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
      List<String>? interestedJobGroupIdList,
      List<String>? techSkillIdList});
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
    Object? interestedJobGroupIdList = freezed,
    Object? techSkillIdList = freezed,
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
      interestedJobGroupIdList: freezed == interestedJobGroupIdList
          ? _value._interestedJobGroupIdList
          : interestedJobGroupIdList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      techSkillIdList: freezed == techSkillIdList
          ? _value._techSkillIdList
          : techSkillIdList // ignore: cast_nullable_to_non_nullable
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
      final List<String>? interestedJobGroupIdList,
      final List<String>? techSkillIdList})
      : _interestedJobGroupIdList = interestedJobGroupIdList,
        _techSkillIdList = techSkillIdList,
        super._();

  factory _$UserDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String? nickname;
  final List<String>? _interestedJobGroupIdList;
  @override
  List<String>? get interestedJobGroupIdList {
    final value = _interestedJobGroupIdList;
    if (value == null) return null;
    if (_interestedJobGroupIdList is EqualUnmodifiableListView)
      return _interestedJobGroupIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _techSkillIdList;
  @override
  List<String>? get techSkillIdList {
    final value = _techSkillIdList;
    if (value == null) return null;
    if (_techSkillIdList is EqualUnmodifiableListView) return _techSkillIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserDataModel(uid: $uid, nickname: $nickname, interestedJobGroupIdList: $interestedJobGroupIdList, techSkillIdList: $techSkillIdList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataModelImpl &&
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
      final List<String>? interestedJobGroupIdList,
      final List<String>? techSkillIdList}) = _$UserDataModelImpl;
  const _UserDataModel._() : super._();

  factory _UserDataModel.fromJson(Map<String, dynamic> json) =
      _$UserDataModelImpl.fromJson;

  @override
  String get uid;
  @override
  String? get nickname;
  @override
  List<String>? get interestedJobGroupIdList;
  @override
  List<String>? get techSkillIdList;
  @override
  @JsonKey(ignore: true)
  _$$UserDataModelImplCopyWith<_$UserDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
