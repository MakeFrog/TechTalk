import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String message,
    required String type,
    required Map<String, dynamic>? qna,
    @TimeStampConverter() required DateTime timestamp,
  }) = _ChatMessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      MessageModel.fromJson(snapshot.data() as Map<String, dynamic>);
}
