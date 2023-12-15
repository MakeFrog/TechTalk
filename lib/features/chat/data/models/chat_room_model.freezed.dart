// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) {
  return _ChatListItemModel.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomModel {
  String get interviewerId => throw _privateConstructorUsedError;
  String get topicId => throw _privateConstructorUsedError;
  int get totalQuestionCount => throw _privateConstructorUsedError;
  int get correctAnswerCount => throw _privateConstructorUsedError;
  int get incorrectAnswerCount => throw _privateConstructorUsedError;
  String get chatRoomId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomModelCopyWith<ChatRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomModelCopyWith<$Res> {
  factory $ChatRoomModelCopyWith(
          ChatRoomModel value, $Res Function(ChatRoomModel) then) =
      _$ChatRoomModelCopyWithImpl<$Res, ChatRoomModel>;
  @useResult
  $Res call(
      {String interviewerId,
      String topicId,
      int totalQuestionCount,
      int correctAnswerCount,
      int incorrectAnswerCount,
      String chatRoomId});
}

/// @nodoc
class _$ChatRoomModelCopyWithImpl<$Res, $Val extends ChatRoomModel>
    implements $ChatRoomModelCopyWith<$Res> {
  _$ChatRoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interviewerId = null,
    Object? topicId = null,
    Object? totalQuestionCount = null,
    Object? correctAnswerCount = null,
    Object? incorrectAnswerCount = null,
    Object? chatRoomId = null,
  }) {
    return _then(_value.copyWith(
      interviewerId: null == interviewerId
          ? _value.interviewerId
          : interviewerId // ignore: cast_nullable_to_non_nullable
              as String,
      topicId: null == topicId
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestionCount: null == totalQuestionCount
          ? _value.totalQuestionCount
          : totalQuestionCount // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswerCount: null == correctAnswerCount
          ? _value.correctAnswerCount
          : correctAnswerCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectAnswerCount: null == incorrectAnswerCount
          ? _value.incorrectAnswerCount
          : incorrectAnswerCount // ignore: cast_nullable_to_non_nullable
              as int,
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatListItemModelImplCopyWith<$Res>
    implements $ChatRoomModelCopyWith<$Res> {
  factory _$$ChatListItemModelImplCopyWith(_$ChatListItemModelImpl value,
          $Res Function(_$ChatListItemModelImpl) then) =
      __$$ChatListItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String interviewerId,
      String topicId,
      int totalQuestionCount,
      int correctAnswerCount,
      int incorrectAnswerCount,
      String chatRoomId});
}

/// @nodoc
class __$$ChatListItemModelImplCopyWithImpl<$Res>
    extends _$ChatRoomModelCopyWithImpl<$Res, _$ChatListItemModelImpl>
    implements _$$ChatListItemModelImplCopyWith<$Res> {
  __$$ChatListItemModelImplCopyWithImpl(_$ChatListItemModelImpl _value,
      $Res Function(_$ChatListItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interviewerId = null,
    Object? topicId = null,
    Object? totalQuestionCount = null,
    Object? correctAnswerCount = null,
    Object? incorrectAnswerCount = null,
    Object? chatRoomId = null,
  }) {
    return _then(_$ChatListItemModelImpl(
      interviewerId: null == interviewerId
          ? _value.interviewerId
          : interviewerId // ignore: cast_nullable_to_non_nullable
              as String,
      topicId: null == topicId
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestionCount: null == totalQuestionCount
          ? _value.totalQuestionCount
          : totalQuestionCount // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswerCount: null == correctAnswerCount
          ? _value.correctAnswerCount
          : correctAnswerCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectAnswerCount: null == incorrectAnswerCount
          ? _value.incorrectAnswerCount
          : incorrectAnswerCount // ignore: cast_nullable_to_non_nullable
              as int,
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatListItemModelImpl implements _ChatListItemModel {
  const _$ChatListItemModelImpl(
      {required this.interviewerId,
      required this.topicId,
      required this.totalQuestionCount,
      required this.correctAnswerCount,
      required this.incorrectAnswerCount,
      required this.chatRoomId});

  factory _$ChatListItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatListItemModelImplFromJson(json);

  @override
  final String interviewerId;
  @override
  final String topicId;
  @override
  final int totalQuestionCount;
  @override
  final int correctAnswerCount;
  @override
  final int incorrectAnswerCount;
  @override
  final String chatRoomId;

  @override
  String toString() {
    return 'ChatRoomModel(interviewerId: $interviewerId, topicId: $topicId, totalQuestionCount: $totalQuestionCount, correctAnswerCount: $correctAnswerCount, incorrectAnswerCount: $incorrectAnswerCount, chatRoomId: $chatRoomId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListItemModelImpl &&
            (identical(other.interviewerId, interviewerId) ||
                other.interviewerId == interviewerId) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.totalQuestionCount, totalQuestionCount) ||
                other.totalQuestionCount == totalQuestionCount) &&
            (identical(other.correctAnswerCount, correctAnswerCount) ||
                other.correctAnswerCount == correctAnswerCount) &&
            (identical(other.incorrectAnswerCount, incorrectAnswerCount) ||
                other.incorrectAnswerCount == incorrectAnswerCount) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, interviewerId, topicId,
      totalQuestionCount, correctAnswerCount, incorrectAnswerCount, chatRoomId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListItemModelImplCopyWith<_$ChatListItemModelImpl> get copyWith =>
      __$$ChatListItemModelImplCopyWithImpl<_$ChatListItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatListItemModelImplToJson(
      this,
    );
  }
}

abstract class _ChatListItemModel implements ChatRoomModel {
  const factory _ChatListItemModel(
      {required final String interviewerId,
      required final String topicId,
      required final int totalQuestionCount,
      required final int correctAnswerCount,
      required final int incorrectAnswerCount,
      required final String chatRoomId}) = _$ChatListItemModelImpl;

  factory _ChatListItemModel.fromJson(Map<String, dynamic> json) =
      _$ChatListItemModelImpl.fromJson;

  @override
  String get interviewerId;
  @override
  String get topicId;
  @override
  int get totalQuestionCount;
  @override
  int get correctAnswerCount;
  @override
  int get incorrectAnswerCount;
  @override
  String get chatRoomId;
  @override
  @JsonKey(ignore: true)
  _$$ChatListItemModelImplCopyWith<_$ChatListItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
