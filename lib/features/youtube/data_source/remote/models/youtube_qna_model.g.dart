// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeQnaModel _$YoutubeQnaModelFromJson(Map<String, dynamic> json) =>
    YoutubeQnaModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$YoutubeQnaModelToJson(YoutubeQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
