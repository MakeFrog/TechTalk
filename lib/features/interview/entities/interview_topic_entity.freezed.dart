// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_topic_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InterviewTopicEntity _$InterviewTopicEntityFromJson(Map<String, dynamic> json) {
  return _InterviewTopicEntity.fromJson(json);
}

/// @nodoc
mixin _$InterviewTopicEntity {
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InterviewTopicEntityCopyWith<InterviewTopicEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterviewTopicEntityCopyWith<$Res> {
  factory $InterviewTopicEntityCopyWith(InterviewTopicEntity value,
          $Res Function(InterviewTopicEntity) then) =
      _$InterviewTopicEntityCopyWithImpl<$Res, InterviewTopicEntity>;
  @useResult
  $Res call({String name, String category, String? imageUrl});
}

/// @nodoc
class _$InterviewTopicEntityCopyWithImpl<$Res,
        $Val extends InterviewTopicEntity>
    implements $InterviewTopicEntityCopyWith<$Res> {
  _$InterviewTopicEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? imageUrl = freezed,
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterviewTopicEntityImplCopyWith<$Res>
    implements $InterviewTopicEntityCopyWith<$Res> {
  factory _$$InterviewTopicEntityImplCopyWith(_$InterviewTopicEntityImpl value,
          $Res Function(_$InterviewTopicEntityImpl) then) =
      __$$InterviewTopicEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String category, String? imageUrl});
}

/// @nodoc
class __$$InterviewTopicEntityImplCopyWithImpl<$Res>
    extends _$InterviewTopicEntityCopyWithImpl<$Res, _$InterviewTopicEntityImpl>
    implements _$$InterviewTopicEntityImplCopyWith<$Res> {
  __$$InterviewTopicEntityImplCopyWithImpl(_$InterviewTopicEntityImpl _value,
      $Res Function(_$InterviewTopicEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$InterviewTopicEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterviewTopicEntityImpl implements _InterviewTopicEntity {
  const _$InterviewTopicEntityImpl(
      {required this.name, required this.category, this.imageUrl});

  factory _$InterviewTopicEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterviewTopicEntityImplFromJson(json);

  @override
  final String name;
  @override
  final String category;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'InterviewTopicEntity(name: $name, category: $category, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewTopicEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, category, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewTopicEntityImplCopyWith<_$InterviewTopicEntityImpl>
      get copyWith =>
          __$$InterviewTopicEntityImplCopyWithImpl<_$InterviewTopicEntityImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterviewTopicEntityImplToJson(
      this,
    );
  }
}

abstract class _InterviewTopicEntity implements InterviewTopicEntity {
  const factory _InterviewTopicEntity(
      {required final String name,
      required final String category,
      final String? imageUrl}) = _$InterviewTopicEntityImpl;

  factory _InterviewTopicEntity.fromJson(Map<String, dynamic> json) =
      _$InterviewTopicEntityImpl.fromJson;

  @override
  String get name;
  @override
  String get category;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$InterviewTopicEntityImplCopyWith<_$InterviewTopicEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
