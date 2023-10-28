// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tech_skill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TechSkillModel _$TechSkillModelFromJson(Map<String, dynamic> json) {
  return _TechSkillModel.fromJson(json);
}

/// @nodoc
mixin _$TechSkillModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechSkillModelCopyWith<TechSkillModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechSkillModelCopyWith<$Res> {
  factory $TechSkillModelCopyWith(
          TechSkillModel value, $Res Function(TechSkillModel) then) =
      _$TechSkillModelCopyWithImpl<$Res, TechSkillModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$TechSkillModelCopyWithImpl<$Res, $Val extends TechSkillModel>
    implements $TechSkillModelCopyWith<$Res> {
  _$TechSkillModelCopyWithImpl(this._value, this._then);

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
abstract class _$$TechSkillModelImplCopyWith<$Res>
    implements $TechSkillModelCopyWith<$Res> {
  factory _$$TechSkillModelImplCopyWith(_$TechSkillModelImpl value,
          $Res Function(_$TechSkillModelImpl) then) =
      __$$TechSkillModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$TechSkillModelImplCopyWithImpl<$Res>
    extends _$TechSkillModelCopyWithImpl<$Res, _$TechSkillModelImpl>
    implements _$$TechSkillModelImplCopyWith<$Res> {
  __$$TechSkillModelImplCopyWithImpl(
      _$TechSkillModelImpl _value, $Res Function(_$TechSkillModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$TechSkillModelImpl(
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
class _$TechSkillModelImpl extends _TechSkillModel {
  const _$TechSkillModelImpl({required this.id, required this.name})
      : super._();

  factory _$TechSkillModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechSkillModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'TechSkillModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechSkillModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TechSkillModelImplCopyWith<_$TechSkillModelImpl> get copyWith =>
      __$$TechSkillModelImplCopyWithImpl<_$TechSkillModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TechSkillModelImplToJson(
      this,
    );
  }
}

abstract class _TechSkillModel extends TechSkillModel {
  const factory _TechSkillModel(
      {required final String id,
      required final String name}) = _$TechSkillModelImpl;
  const _TechSkillModel._() : super._();

  factory _TechSkillModel.fromJson(Map<String, dynamic> json) =
      _$TechSkillModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$TechSkillModelImplCopyWith<_$TechSkillModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
