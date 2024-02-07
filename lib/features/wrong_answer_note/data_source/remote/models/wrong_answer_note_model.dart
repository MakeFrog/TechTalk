import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/wrong_answer_note/data_source/remote/models/wrong_answer_note_answer_model.dart';

part 'wrong_answer_note_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WrongAnswerNoteModel {
  WrongAnswerNoteModel({
    required this.id,
    required this.answers,
    required this.updatedAt,
  });

  final String id;
  final List<WrongAnswerNoteAnswerModel> answers;
  @TimeStampConverter()
  final DateTime updatedAt;

  factory WrongAnswerNoteModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      WrongAnswerNoteModel.fromJson(snapshot.data()!);

  factory WrongAnswerNoteModel.fromJson(Map<String, dynamic> json) {
    return _$WrongAnswerNoteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WrongAnswerNoteModelToJson(this);
}
