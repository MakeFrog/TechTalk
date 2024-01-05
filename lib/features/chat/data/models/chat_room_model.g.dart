// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    ChatRoomModel(
      id: json['id'] as String,
      interviewerId: json['interviewer_id'] as String,
      topicIds:
          (json['topic_ids'] as List<dynamic>).map((e) => e as String).toList(),
      type: $enumDecode(_$InterviewTypeEnumMap, json['type']),
      totalQuestionCount: json['total_question_count'] as int,
      correctAnswerCount: json['correct_answer_count'] as int,
      incorrectAnswerCount: json['incorrect_answer_count'] as int,
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'interviewer_id': instance.interviewerId,
      'topic_ids': instance.topicIds,
      'type': _$InterviewTypeEnumMap[instance.type]!,
      'total_question_count': instance.totalQuestionCount,
      'correct_answer_count': instance.correctAnswerCount,
      'incorrect_answer_count': instance.incorrectAnswerCount,
    };

const _$InterviewTypeEnumMap = {
  InterviewType.topic: 'topic',
  InterviewType.practical: 'practical',
};
