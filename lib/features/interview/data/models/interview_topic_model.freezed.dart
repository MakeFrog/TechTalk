// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_topic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InterviewTopicModel _$InterviewTopicModelFromJson(Map<String, dynamic> json) {
  return _InterviewTopicModel.fromJson(json);
}

/// @nodoc
mixin _$InterviewTopicModel {
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get topicImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InterviewTopicModelCopyWith<InterviewTopicModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterviewTopicModelCopyWith<$Res> {
  factory $InterviewTopicModelCopyWith(
          InterviewTopicModel value, $Res Function(InterviewTopicModel) then) =
      _$InterviewTopicModelCopyWithImpl<$Res, InterviewTopicModel>;
  @useResult
  $Res call({String name, String category, String? topicImageUrl});
}

/// @nodoc
class _$InterviewTopicModelCopyWithImpl<$Res, $Val extends InterviewTopicModel>
    implements $InterviewTopicModelCopyWith<$Res> {
  _$InterviewTopicModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? topicImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      topicImageUrl: freezed == topicImageUrl
          ? _value.topicImageUrl
          : topicImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterviewTopicModelImplCopyWith<$Res>
    implements $InterviewTopicModelCopyWith<$Res> {
  factory _$$InterviewTopicModelImplCopyWith(_$InterviewTopicModelImpl value,
          $Res Function(_$InterviewTopicModelImpl) then) =
      __$$InterviewTopicModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String category, String? topicImageUrl});
}

/// @nodoc
class __$$InterviewTopicModelImplCopyWithImpl<$Res>
    extends _$InterviewTopicModelCopyWithImpl<$Res, _$InterviewTopicModelImpl>
    implements _$$InterviewTopicModelImplCopyWith<$Res> {
  __$$InterviewTopicModelImplCopyWithImpl(_$InterviewTopicModelImpl _value,
      $Res Function(_$InterviewTopicModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? topicImageUrl = freezed,
  }) {
    return _then(_$InterviewTopicModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      topicImageUrl: freezed == topicImageUrl
          ? _value.topicImageUrl
          : topicImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterviewTopicModelImpl implements _InterviewTopicModel {
  const _$InterviewTopicModelImpl(
      {required this.name, required this.category, this.topicImageUrl});

  factory _$InterviewTopicModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterviewTopicModelImplFromJson(json);

  @override
  final String name;
  @override
  final String category;
  @override
  final String? topicImageUrl;

  @override
  String toString() {
    return 'InterviewTopicModel(name: $name, category: $category, topicImageUrl: $topicImageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewTopicModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.topicImageUrl, topicImageUrl) ||
                other.topicImageUrl == topicImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, category, topicImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewTopicModelImplCopyWith<_$InterviewTopicModelImpl> get copyWith =>
      __$$InterviewTopicModelImplCopyWithImpl<_$InterviewTopicModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterviewTopicModelImplToJson(
      this,
    );
  }
}

abstract class _InterviewTopicModel implements InterviewTopicModel {
  const factory _InterviewTopicModel(
      {required final String name,
      required final String category,
      final String? topicImageUrl}) = _$InterviewTopicModelImpl;

  factory _InterviewTopicModel.fromJson(Map<String, dynamic> json) =
      _$InterviewTopicModelImpl.fromJson;

  @override
  String get name;
  @override
  String get category;
  @override
  String? get topicImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$InterviewTopicModelImplCopyWith<_$InterviewTopicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
