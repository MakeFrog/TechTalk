// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatListItemModelImpl _$$ChatListItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatListItemModelImpl(
      interviewerId: json['interviewerId'] as String,
      topicId: json['topicId'] as String,
      totalQuestionCount: json['totalQuestionCount'] as int,
      correctAnswerCount: json['correctAnswerCount'] as int,
      incorrectAnswerCount: json['incorrectAnswerCount'] as int,
      chatRoomId: json['chatRoomId'] as String,
    );

Map<String, dynamic> _$$ChatListItemModelImplToJson(
        _$ChatListItemModelImpl instance) =>
    <String, dynamic>{
      'interviewerId': instance.interviewerId,
      'topicId': instance.topicId,
      'totalQuestionCount': instance.totalQuestionCount,
      'correctAnswerCount': instance.correctAnswerCount,
      'incorrectAnswerCount': instance.incorrectAnswerCount,
      'chatRoomId': instance.chatRoomId,
    };
