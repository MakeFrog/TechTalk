// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tech_skill_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TechSkillEntity _$TechSkillEntityFromJson(Map<String, dynamic> json) {
  return _TechSkillEntity.fromJson(json);
}

/// @nodoc
mixin _$TechSkillEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechSkillEntityCopyWith<TechSkillEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechSkillEntityCopyWith<$Res> {
  factory $TechSkillEntityCopyWith(
          TechSkillEntity value, $Res Function(TechSkillEntity) then) =
      _$TechSkillEntityCopyWithImpl<$Res, TechSkillEntity>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$TechSkillEntityCopyWithImpl<$Res, $Val extends TechSkillEntity>
    implements $TechSkillEntityCopyWith<$Res> {
  _$TechSkillEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TechSkillEntityImplCopyWith<$Res>
    implements $TechSkillEntityCopyWith<$Res> {
  factory _$$TechSkillEntityImplCopyWith(_$TechSkillEntityImpl value,
          $Res Function(_$TechSkillEntityImpl) then) =
      __$$TechSkillEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$TechSkillEntityImplCopyWithImpl<$Res>
    extends _$TechSkillEntityCopyWithImpl<$Res, _$TechSkillEntityImpl>
    implements _$$TechSkillEntityImplCopyWith<$Res> {
  __$$TechSkillEntityImplCopyWithImpl(
      _$TechSkillEntityImpl _value, $Res Function(_$TechSkillEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$TechSkillEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TechSkillEntityImpl implements _TechSkillEntity {
  const _$TechSkillEntityImpl({required this.id, required this.name});

  factory _$TechSkillEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechSkillEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'TechSkillEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechSkillEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TechSkillEntityImplCopyWith<_$TechSkillEntityImpl> get copyWith =>
      __$$TechSkillEntityImplCopyWithImpl<_$TechSkillEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TechSkillEntityImplToJson(
      this,
    );
  }
}

abstract class _TechSkillEntity implements TechSkillEntity {
  const factory _TechSkillEntity(
      {required final String id,
      required final String name}) = _$TechSkillEntityImpl;

  factory _TechSkillEntity.fromJson(Map<String, dynamic> json) =
      _$TechSkillEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$TechSkillEntityImplCopyWith<_$TechSkillEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
