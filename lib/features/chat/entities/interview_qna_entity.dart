import 'package:techtalk/features/chat/entities/user_interview_response.dart';
import 'package:techtalk/features/topic/topic.dart';

class InterviewQnAEntity {
  final String id; // 질문 Id
  final TopicQuestionEntity question;
  final UserInterviewResponse? response; // 유저 응답

  bool get hasUserResponded => response != null;

//<editor-fold desc="Data Methods">
  InterviewQnAEntity({
    required this.id,
    required this.question,
    this.response,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewQnAEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          response == other.response);

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ response.hashCode;

  @override
  String toString() {
    return 'InterviewQnAEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        ' response: $response,' +
        '}';
  }

  InterviewQnAEntity copyWith({
    String? id,
    TopicQuestionEntity? question,
    UserInterviewResponse? response,
  }) {
    return InterviewQnAEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      response: response ?? this.response,
    );
  }

//</editor-fold>
}
