// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrongAnswerModel _$WrongAnswerModelFromJson(Map<String, dynamic> json) =>
    WrongAnswerModel(
      id: json['id'] as String,
      updatedAt:
          const TimeStampConverter().fromJson(json['updated_at'] as Timestamp),
      userAnswer: json['user_answer'] as String,
      wrongAnswerCount: (json['wrong_answer_count'] as num).toInt(),
    );

Map<String, dynamic> _$WrongAnswerModelToJson(WrongAnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': const TimeStampConverter().toJson(instance.updatedAt),
      'user_answer': instance.userAnswer,
      'wrong_answer_count': instance.wrongAnswerCount,
    };
