// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewRoomModel _$InterviewRoomModelFromJson(Map<String, dynamic> json) =>
    InterviewRoomModel(
      interviewerId: json['interviewer_id'] as String,
      topicId: json['topic_id'] as String,
      totalQuestionCount: json['total_question_count'] as int,
      correctAnswerCount: json['correct_answer_count'] as int,
      incorrectAnswerCount: json['incorrect_answer_count'] as int,
      chatRoomId: json['chat_room_id'] as String,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InterviewRoomModelToJson(InterviewRoomModel instance) =>
    <String, dynamic>{
      'interviewer_id': instance.interviewerId,
      'topic_id': instance.topicId,
      'total_question_count': instance.totalQuestionCount,
      'correct_answer_count': instance.correctAnswerCount,
      'incorrect_answer_count': instance.incorrectAnswerCount,
      'chat_room_id': instance.chatRoomId,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$ChatListItemModelImpl _$$ChatListItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatListItemModelImpl(
      interviewerId: json['interviewerId'] as String,
      topicId: json['topicId'] as String,
      totalQuestionCount: json['totalQuestionCount'] as int,
      correctAnswerCount: json['correctAnswerCount'] as int,
      incorrectAnswerCount: json['incorrectAnswerCount'] as int,
      chatRoomId: json['chatRoomId'] as String,
    );

Map<String, dynamic> _$$ChatListItemModelImplToJson(
        _$ChatListItemModelImpl instance) =>
    <String, dynamic>{
      'interviewerId': instance.interviewerId,
      'topicId': instance.topicId,
      'totalQuestionCount': instance.totalQuestionCount,
      'correctAnswerCount': instance.correctAnswerCount,
      'incorrectAnswerCount': instance.incorrectAnswerCount,
      'chatRoomId': instance.chatRoomId,
    };
