// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JobGroupModel _$JobGroupModelFromJson(Map<String, dynamic> json) {
  return _JobGroupModel.fromJson(json);
}

/// @nodoc
mixin _$JobGroupModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobGroupModelCopyWith<JobGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobGroupModelCopyWith<$Res> {
  factory $JobGroupModelCopyWith(
          JobGroupModel value, $Res Function(JobGroupModel) then) =
      _$JobGroupModelCopyWithImpl<$Res, JobGroupModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$JobGroupModelCopyWithImpl<$Res, $Val extends JobGroupModel>
    implements $JobGroupModelCopyWith<$Res> {
  _$JobGroupModelCopyWithImpl(this._value, this._then);

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
abstract class _$$JobGroupModelImplCopyWith<$Res>
    implements $JobGroupModelCopyWith<$Res> {
  factory _$$JobGroupModelImplCopyWith(
          _$JobGroupModelImpl value, $Res Function(_$JobGroupModelImpl) then) =
      __$$JobGroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$JobGroupModelImplCopyWithImpl<$Res>
    extends _$JobGroupModelCopyWithImpl<$Res, _$JobGroupModelImpl>
    implements _$$JobGroupModelImplCopyWith<$Res> {
  __$$JobGroupModelImplCopyWithImpl(
      _$JobGroupModelImpl _value, $Res Function(_$JobGroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$JobGroupModelImpl(
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
class _$JobGroupModelImpl extends _JobGroupModel {
  const _$JobGroupModelImpl({required this.id, required this.name}) : super._();

  factory _$JobGroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobGroupModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'JobGroupModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobGroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobGroupModelImplCopyWith<_$JobGroupModelImpl> get copyWith =>
      __$$JobGroupModelImplCopyWithImpl<_$JobGroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobGroupModelImplToJson(
      this,
    );
  }
}

abstract class _JobGroupModel extends JobGroupModel {
  const factory _JobGroupModel(
      {required final String id,
      required final String name}) = _$JobGroupModelImpl;
  const _JobGroupModel._() : super._();

  factory _JobGroupModel.fromJson(Map<String, dynamic> json) =
      _$JobGroupModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$JobGroupModelImplCopyWith<_$JobGroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
