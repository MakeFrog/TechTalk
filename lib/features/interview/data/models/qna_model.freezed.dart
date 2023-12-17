// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qna_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QnaModel _$QnaModelFromJson(Map<String, dynamic> json) {
  return _QnaModel.fromJson(json);
}

/// @nodoc
mixin _$QnaModel {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QnaModelCopyWith<QnaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QnaModelCopyWith<$Res> {
  factory $QnaModelCopyWith(QnaModel value, $Res Function(QnaModel) then) =
      _$QnaModelCopyWithImpl<$Res, QnaModel>;
  @useResult
  $Res call({String id, String question, List<String> answers});
}

/// @nodoc
class _$QnaModelCopyWithImpl<$Res, $Val extends QnaModel>
    implements $QnaModelCopyWith<$Res> {
  _$QnaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$QnaModelImplCopyWith<$Res>
    implements $QnaModelCopyWith<$Res> {
  factory _$$QnaModelImplCopyWith(
          _$QnaModelImpl value, $Res Function(_$QnaModelImpl) then) =
      __$$QnaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String question, List<String> answers});
}

/// @nodoc
class __$$QnaModelImplCopyWithImpl<$Res>
    extends _$QnaModelCopyWithImpl<$Res, _$QnaModelImpl>
    implements _$$QnaModelImplCopyWith<$Res> {
  __$$QnaModelImplCopyWithImpl(
      _$QnaModelImpl _value, $Res Function(_$QnaModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? answers = null,
  }) {
    return _then(_$QnaModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$QnaModelImpl implements _QnaModel {
  const _$QnaModelImpl(
      {required this.id,
      required this.question,
      required final List<String> answers})
      : _answers = answers;

  factory _$QnaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QnaModelImplFromJson(json);

  @override
  final String id;
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
    return 'QnaModel(id: $id, question: $question, answers: $answers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QnaModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, question, const DeepCollectionEquality().hash(_answers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QnaModelImplCopyWith<_$QnaModelImpl> get copyWith =>
      __$$QnaModelImplCopyWithImpl<_$QnaModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QnaModelImplToJson(
      this,
    );
  }
}

abstract class _QnaModel implements QnaModel {
  const factory _QnaModel(
      {required final String id,
      required final String question,
      required final List<String> answers}) = _$QnaModelImpl;

  factory _QnaModel.fromJson(Map<String, dynamic> json) =
      _$QnaModelImpl.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  List<String> get answers;
  @override
  @JsonKey(ignore: true)
  _$$QnaModelImplCopyWith<_$QnaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
