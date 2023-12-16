// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicQuestionModel _$TopicQuestionModelFromJson(Map<String, dynamic> json) =>
    TopicQuestionModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TopicQuestionModelToJson(TopicQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
    };
