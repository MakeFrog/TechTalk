// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicQnaModel _$TopicQnaModelFromJson(Map<String, dynamic> json) =>
    TopicQnaModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TopicQnaModelToJson(TopicQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
    };
