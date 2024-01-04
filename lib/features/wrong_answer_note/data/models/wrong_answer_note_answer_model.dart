import 'package:json_annotation/json_annotation.dart';

part 'wrong_answer_note_answer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WrongAnswerNoteAnswerModel {
  WrongAnswerNoteAnswerModel({
    required this.chatRoomId,
    required this.messageId,
  });

  final String chatRoomId;
  final String messageId;

  factory WrongAnswerNoteAnswerModel.fromJson(Map<String, dynamic> json) {
    return _$WrongAnswerNoteAnswerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WrongAnswerNoteAnswerModelToJson(this);
}
