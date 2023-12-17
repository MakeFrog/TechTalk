// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QnaModelImpl _$$QnaModelImplFromJson(Map<String, dynamic> json) =>
    _$QnaModelImpl(
      id: json['id'] as String,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$QnaModelImplToJson(_$QnaModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
    };
