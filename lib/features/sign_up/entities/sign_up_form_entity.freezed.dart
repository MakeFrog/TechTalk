// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_form_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignUpFormEntity _$SignUpFormEntityFromJson(Map<String, dynamic> json) {
  return _SignUpFormEntity.fromJson(json);
}

/// @nodoc
mixin _$SignUpFormEntity {
  String? get nickname => throw _privateConstructorUsedError;
  String? get nicknameValidation => throw _privateConstructorUsedError;
  List<JobGroupModel> get jobGroupList => throw _privateConstructorUsedError;
  List<TechSkillEntity> get techSkillList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpFormEntityCopyWith<SignUpFormEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpFormEntityCopyWith<$Res> {
  factory $SignUpFormEntityCopyWith(
          SignUpFormEntity value, $Res Function(SignUpFormEntity) then) =
      _$SignUpFormEntityCopyWithImpl<$Res, SignUpFormEntity>;
  @useResult
  $Res call(
      {String? nickname,
      String? nicknameValidation,
      List<JobGroupModel> jobGroupList,
      List<TechSkillEntity> techSkillList});
}

/// @nodoc
class _$SignUpFormEntityCopyWithImpl<$Res, $Val extends SignUpFormEntity>
    implements $SignUpFormEntityCopyWith<$Res> {
  _$SignUpFormEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? nicknameValidation = freezed,
    Object? jobGroupList = null,
    Object? techSkillList = null,
  }) {
    return _then(_value.copyWith(
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      nicknameValidation: freezed == nicknameValidation
          ? _value.nicknameValidation
          : nicknameValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      jobGroupList: null == jobGroupList
          ? _value.jobGroupList
          : jobGroupList // ignore: cast_nullable_to_non_nullable
              as List<JobGroupModel>,
      techSkillList: null == techSkillList
          ? _value.techSkillList
          : techSkillList // ignore: cast_nullable_to_non_nullable
              as List<TechSkillEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpFormEntityImplCopyWith<$Res>
    implements $SignUpFormEntityCopyWith<$Res> {
  factory _$$SignUpFormEntityImplCopyWith(_$SignUpFormEntityImpl value,
          $Res Function(_$SignUpFormEntityImpl) then) =
      __$$SignUpFormEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nickname,
      String? nicknameValidation,
      List<JobGroupModel> jobGroupList,
      List<TechSkillEntity> techSkillList});
}

/// @nodoc
class __$$SignUpFormEntityImplCopyWithImpl<$Res>
    extends _$SignUpFormEntityCopyWithImpl<$Res, _$SignUpFormEntityImpl>
    implements _$$SignUpFormEntityImplCopyWith<$Res> {
  __$$SignUpFormEntityImplCopyWithImpl(_$SignUpFormEntityImpl _value,
      $Res Function(_$SignUpFormEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? nicknameValidation = freezed,
    Object? jobGroupList = null,
    Object? techSkillList = null,
  }) {
    return _then(_$SignUpFormEntityImpl(
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      nicknameValidation: freezed == nicknameValidation
          ? _value.nicknameValidation
          : nicknameValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      jobGroupList: null == jobGroupList
          ? _value._jobGroupList
          : jobGroupList // ignore: cast_nullable_to_non_nullable
              as List<JobGroupModel>,
      techSkillList: null == techSkillList
          ? _value._techSkillList
          : techSkillList // ignore: cast_nullable_to_non_nullable
              as List<TechSkillEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpFormEntityImpl extends _SignUpFormEntity {
  const _$SignUpFormEntityImpl(
      {this.nickname,
      this.nicknameValidation,
      final List<JobGroupModel> jobGroupList = const [],
      final List<TechSkillEntity> techSkillList = const []})
      : _jobGroupList = jobGroupList,
        _techSkillList = techSkillList,
        super._();

  factory _$SignUpFormEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpFormEntityImplFromJson(json);

  @override
  final String? nickname;
  @override
  final String? nicknameValidation;
  final List<JobGroupModel> _jobGroupList;
  @override
  @JsonKey()
  List<JobGroupModel> get jobGroupList {
    if (_jobGroupList is EqualUnmodifiableListView) return _jobGroupList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_jobGroupList);
  }

  final List<TechSkillEntity> _techSkillList;
  @override
  @JsonKey()
  List<TechSkillEntity> get techSkillList {
    if (_techSkillList is EqualUnmodifiableListView) return _techSkillList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techSkillList);
  }

  @override
  String toString() {
    return 'SignUpFormEntity(nickname: $nickname, nicknameValidation: $nicknameValidation, jobGroupList: $jobGroupList, techSkillList: $techSkillList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpFormEntityImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.nicknameValidation, nicknameValidation) ||
                other.nicknameValidation == nicknameValidation) &&
            const DeepCollectionEquality()
                .equals(other._jobGroupList, _jobGroupList) &&
            const DeepCollectionEquality()
                .equals(other._techSkillList, _techSkillList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nickname,
      nicknameValidation,
      const DeepCollectionEquality().hash(_jobGroupList),
      const DeepCollectionEquality().hash(_techSkillList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpFormEntityImplCopyWith<_$SignUpFormEntityImpl> get copyWith =>
      __$$SignUpFormEntityImplCopyWithImpl<_$SignUpFormEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpFormEntityImplToJson(
      this,
    );
  }
}

abstract class _SignUpFormEntity extends SignUpFormEntity {
  const factory _SignUpFormEntity(
      {final String? nickname,
      final String? nicknameValidation,
      final List<JobGroupModel> jobGroupList,
      final List<TechSkillEntity> techSkillList}) = _$SignUpFormEntityImpl;
  const _SignUpFormEntity._() : super._();

  factory _SignUpFormEntity.fromJson(Map<String, dynamic> json) =
      _$SignUpFormEntityImpl.fromJson;

  @override
  String? get nickname;
  @override
  String? get nicknameValidation;
  @override
  List<JobGroupModel> get jobGroupList;
  @override
  List<TechSkillEntity> get techSkillList;
  @override
  @JsonKey(ignore: true)
  _$$SignUpFormEntityImplCopyWith<_$SignUpFormEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
