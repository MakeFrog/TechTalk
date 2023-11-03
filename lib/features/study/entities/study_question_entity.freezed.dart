// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_question_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyQuestionEntity _$StudyQuestionEntityFromJson(Map<String, dynamic> json) {
  return _StudyQuestionEntity.fromJson(json);
}

/// @nodoc
mixin _$StudyQuestionEntity {
  String get question => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyQuestionEntityCopyWith<StudyQuestionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyQuestionEntityCopyWith<$Res> {
  factory $StudyQuestionEntityCopyWith(
          StudyQuestionEntity value, $Res Function(StudyQuestionEntity) then) =
      _$StudyQuestionEntityCopyWithImpl<$Res, StudyQuestionEntity>;
  @useResult
  $Res call({String question, List<String> answers});
}

/// @nodoc
class _$StudyQuestionEntityCopyWithImpl<$Res, $Val extends StudyQuestionEntity>
    implements $StudyQuestionEntityCopyWith<$Res> {
  _$StudyQuestionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyQuestionEntityImplCopyWith<$Res>
    implements $StudyQuestionEntityCopyWith<$Res> {
  factory _$$StudyQuestionEntityImplCopyWith(_$StudyQuestionEntityImpl value,
          $Res Function(_$StudyQuestionEntityImpl) then) =
      __$$StudyQuestionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, List<String> answers});
}

/// @nodoc
class __$$StudyQuestionEntityImplCopyWithImpl<$Res>
    extends _$StudyQuestionEntityCopyWithImpl<$Res, _$StudyQuestionEntityImpl>
    implements _$$StudyQuestionEntityImplCopyWith<$Res> {
  __$$StudyQuestionEntityImplCopyWithImpl(_$StudyQuestionEntityImpl _value,
      $Res Function(_$StudyQuestionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answers = null,
  }) {
    return _then(_$StudyQuestionEntityImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyQuestionEntityImpl implements _StudyQuestionEntity {
  const _$StudyQuestionEntityImpl(
      {required this.question, required final List<String> answers})
      : _answers = answers;

  factory _$StudyQuestionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyQuestionEntityImplFromJson(json);

  @override
  final String question;
  final List<String> _answers;
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'StudyQuestionEntity(question: $question, answers: $answers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyQuestionEntityImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, question, const DeepCollectionEquality().hash(_answers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyQuestionEntityImplCopyWith<_$StudyQuestionEntityImpl> get copyWith =>
      __$$StudyQuestionEntityImplCopyWithImpl<_$StudyQuestionEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyQuestionEntityImplToJson(
      this,
    );
  }
}

abstract class _StudyQuestionEntity implements StudyQuestionEntity {
  const factory _StudyQuestionEntity(
      {required final String question,
      required final List<String> answers}) = _$StudyQuestionEntityImpl;

  factory _StudyQuestionEntity.fromJson(Map<String, dynamic> json) =
      _$StudyQuestionEntityImpl.fromJson;

  @override
  String get question;
  @override
  List<String> get answers;
  @override
  @JsonKey(ignore: true)
  _$$StudyQuestionEntityImplCopyWith<_$StudyQuestionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
