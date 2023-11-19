import 'package:json_annotation/json_annotation.dart';

part 'interview_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewQnaModel {
  InterviewQnaModel({
    required this.id,
    required this.question,
    required this.answers,
    required this.myAnswer,
  });

  final String id;
  final String question;
  final List<String> answers;
  final String myAnswer;

  factory InterviewQnaModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewQnaModelToJson(this);
}
