// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answer_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrongAnswerNoteModel _$WrongAnswerNoteModelFromJson(
        Map<String, dynamic> json) =>
    WrongAnswerNoteModel(
      id: json['id'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) =>
              WrongAnswerNoteAnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt:
          const TimeStampConverter().fromJson(json['updated_at'] as Timestamp),
    );

Map<String, dynamic> _$WrongAnswerNoteModelToJson(
        WrongAnswerNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
      'updated_at': const TimeStampConverter().toJson(instance.updatedAt),
    };
