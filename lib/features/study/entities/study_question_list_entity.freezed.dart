// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_question_list_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyQuestionListEntity _$StudyQuestionListEntityFromJson(
    Map<String, dynamic> json) {
  return _StudyQuestionListEntity.fromJson(json);
}

/// @nodoc
mixin _$StudyQuestionListEntity {
  List<StudyQuestionEntity> get questions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyQuestionListEntityCopyWith<StudyQuestionListEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyQuestionListEntityCopyWith<$Res> {
  factory $StudyQuestionListEntityCopyWith(StudyQuestionListEntity value,
          $Res Function(StudyQuestionListEntity) then) =
      _$StudyQuestionListEntityCopyWithImpl<$Res, StudyQuestionListEntity>;
  @useResult
  $Res call({List<StudyQuestionEntity> questions});
}

/// @nodoc
class _$StudyQuestionListEntityCopyWithImpl<$Res,
        $Val extends StudyQuestionListEntity>
    implements $StudyQuestionListEntityCopyWith<$Res> {
  _$StudyQuestionListEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
  }) {
    return _then(_value.copyWith(
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<StudyQuestionEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyQuestionListEntityImplCopyWith<$Res>
    implements $StudyQuestionListEntityCopyWith<$Res> {
  factory _$$StudyQuestionListEntityImplCopyWith(
          _$StudyQuestionListEntityImpl value,
          $Res Function(_$StudyQuestionListEntityImpl) then) =
      __$$StudyQuestionListEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StudyQuestionEntity> questions});
}

/// @nodoc
class __$$StudyQuestionListEntityImplCopyWithImpl<$Res>
    extends _$StudyQuestionListEntityCopyWithImpl<$Res,
        _$StudyQuestionListEntityImpl>
    implements _$$StudyQuestionListEntityImplCopyWith<$Res> {
  __$$StudyQuestionListEntityImplCopyWithImpl(
      _$StudyQuestionListEntityImpl _value,
      $Res Function(_$StudyQuestionListEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
  }) {
    return _then(_$StudyQuestionListEntityImpl(
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<StudyQuestionEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyQuestionListEntityImpl
    with DiagnosticableTreeMixin
    implements _StudyQuestionListEntity {
  const _$StudyQuestionListEntityImpl(
      {required final List<StudyQuestionEntity> questions})
      : _questions = questions;

  factory _$StudyQuestionListEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyQuestionListEntityImplFromJson(json);

  final List<StudyQuestionEntity> _questions;
  @override
  List<StudyQuestionEntity> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StudyQuestionListEntity(questions: $questions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StudyQuestionListEntity'))
      ..add(DiagnosticsProperty('questions', questions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyQuestionListEntityImpl &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_questions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyQuestionListEntityImplCopyWith<_$StudyQuestionListEntityImpl>
      get copyWith => __$$StudyQuestionListEntityImplCopyWithImpl<
          _$StudyQuestionListEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyQuestionListEntityImplToJson(
      this,
    );
  }
}

abstract class _StudyQuestionListEntity implements StudyQuestionListEntity {
  const factory _StudyQuestionListEntity(
          {required final List<StudyQuestionEntity> questions}) =
      _$StudyQuestionListEntityImpl;

  factory _StudyQuestionListEntity.fromJson(Map<String, dynamic> json) =
      _$StudyQuestionListEntityImpl.fromJson;

  @override
  List<StudyQuestionEntity> get questions;
  @override
  @JsonKey(ignore: true)
  _$$StudyQuestionListEntityImplCopyWith<_$StudyQuestionListEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
