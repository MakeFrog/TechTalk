// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_group_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JobGroupListModel _$JobGroupListModelFromJson(Map<String, dynamic> json) {
  return _JobGroupListModel.fromJson(json);
}

/// @nodoc
mixin _$JobGroupListModel {
  List<JobGroupModel> get groups => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobGroupListModelCopyWith<JobGroupListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobGroupListModelCopyWith<$Res> {
  factory $JobGroupListModelCopyWith(
          JobGroupListModel value, $Res Function(JobGroupListModel) then) =
      _$JobGroupListModelCopyWithImpl<$Res, JobGroupListModel>;
  @useResult
  $Res call({List<JobGroupModel> groups});
}

/// @nodoc
class _$JobGroupListModelCopyWithImpl<$Res, $Val extends JobGroupListModel>
    implements $JobGroupListModelCopyWith<$Res> {
  _$JobGroupListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = null,
  }) {
    return _then(_value.copyWith(
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<JobGroupModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobGroupListModelImplCopyWith<$Res>
    implements $JobGroupListModelCopyWith<$Res> {
  factory _$$JobGroupListModelImplCopyWith(_$JobGroupListModelImpl value,
          $Res Function(_$JobGroupListModelImpl) then) =
      __$$JobGroupListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<JobGroupModel> groups});
}

/// @nodoc
class __$$JobGroupListModelImplCopyWithImpl<$Res>
    extends _$JobGroupListModelCopyWithImpl<$Res, _$JobGroupListModelImpl>
    implements _$$JobGroupListModelImplCopyWith<$Res> {
  __$$JobGroupListModelImplCopyWithImpl(_$JobGroupListModelImpl _value,
      $Res Function(_$JobGroupListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = null,
  }) {
    return _then(_$JobGroupListModelImpl(
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<JobGroupModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobGroupListModelImpl implements _JobGroupListModel {
  const _$JobGroupListModelImpl({required final List<JobGroupModel> groups})
      : _groups = groups;

  factory _$JobGroupListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobGroupListModelImplFromJson(json);

  final List<JobGroupModel> _groups;
  @override
  List<JobGroupModel> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  String toString() {
    return 'JobGroupListModel(groups: $groups)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobGroupListModelImpl &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobGroupListModelImplCopyWith<_$JobGroupListModelImpl> get copyWith =>
      __$$JobGroupListModelImplCopyWithImpl<_$JobGroupListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobGroupListModelImplToJson(
      this,
    );
  }
}

abstract class _JobGroupListModel implements JobGroupListModel {
  const factory _JobGroupListModel(
      {required final List<JobGroupModel> groups}) = _$JobGroupListModelImpl;

  factory _JobGroupListModel.fromJson(Map<String, dynamic> json) =
      _$JobGroupListModelImpl.fromJson;

  @override
  List<JobGroupModel> get groups;
  @override
  @JsonKey(ignore: true)
  _$$JobGroupListModelImplCopyWith<_$JobGroupListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
