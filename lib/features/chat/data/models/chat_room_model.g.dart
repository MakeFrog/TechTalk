// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    ChatRoomModel(
      interviewerId: json['interviewer_id'] as String,
      topicId: json['topic_id'] as String,
      totalQuestionCount: json['total_question_count'] as int,
      correctAnswerCount: json['correct_answer_count'] as int,
      incorrectAnswerCount: json['incorrect_answer_count'] as int,
      chatRoomId: json['chat_room_id'] as String,
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      'interviewer_id': instance.interviewerId,
      'topic_id': instance.topicId,
      'total_question_count': instance.totalQuestionCount,
      'correct_answer_count': instance.correctAnswerCount,
      'incorrect_answer_count': instance.incorrectAnswerCount,
      'chat_room_id': instance.chatRoomId,
    };
