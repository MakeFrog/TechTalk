// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answer_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrongAnswerQnAModel _$WrongAnswerQnAModelFromJson(Map<String, dynamic> json) =>
    WrongAnswerQnAModel(
      id: json['id'] as String,
      chatRoomId: json['chat_room_id'] as String,
      qnaId: json['qna_id'] as String,
    );

Map<String, dynamic> _$WrongAnswerQnAModelToJson(
        WrongAnswerQnAModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_room_id': instance.chatRoomId,
      'qna_id': instance.qnaId,
    };
