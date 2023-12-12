import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/interview_new/chat/interview_chat.dart';
import 'package:techtalk/features/interview_new/question/interview_question.dart';

part 'interview_answer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewAnswerModel {
  InterviewAnswerModel({
    required this.id,
    required this.questionId,
    required this.chatId,
    required this.answer,
    required this.answerState,
  });

  final String id;
  final String questionId;
  final String chatId;
  final String answerState;
  final String answer;

  InterviewAnswerEntity toEntity() {
    return InterviewAnswerEntity(
      id: id,
      questionId: questionId,
      chatId: chatId,
      answerState: AnswerState.getStateById(answerState),
      answer: answer,
    );
  }

  factory InterviewAnswerModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewAnswerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewAnswerModelToJson(this);
}
