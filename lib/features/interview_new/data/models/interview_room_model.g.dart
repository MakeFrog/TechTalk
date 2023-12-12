// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewRoomModel _$InterviewRoomModelFromJson(Map<String, dynamic> json) =>
    InterviewRoomModel(
      id: json['id'] as String,
      interviewerId: json['interviewer_id'] as String,
      topicId: json['topic_id'] as String,
      questionCount: json['question_count'] as int,
      correctAnswerCount: json['correct_answer_count'] as int,
      incorrectAnswerCount: json['incorrect_answer_count'] as int,
    );

Map<String, dynamic> _$InterviewRoomModelToJson(InterviewRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'interviewer_id': instance.interviewerId,
      'topic_id': instance.topicId,
      'question_count': instance.questionCount,
      'correct_answer_count': instance.correctAnswerCount,
      'incorrect_answer_count': instance.incorrectAnswerCount,
    };
