import 'package:techtalk/features/topic/topic.dart';

class WrongAnswerQnAEntity {
  final String id;
  final String chatRoomId;
  final TopicQuestionEntity question;
  final List<String> answers;

//<editor-fold desc="Data Methods">
  const WrongAnswerQnAEntity({
    required this.id,
    required this.chatRoomId,
    required this.question,
    required this.answers,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswerQnAEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          chatRoomId == other.chatRoomId &&
          question == other.question &&
          answers == other.answers);

  @override
  int get hashCode =>
      id.hashCode ^ chatRoomId.hashCode ^ question.hashCode ^ answers.hashCode;

  @override
  String toString() {
    return 'WrongAnswerQnAEntity{' +
        ' id: $id,' +
        ' chatRoomId: $chatRoomId,' +
        ' question: $question,' +
        ' answers: $answers,' +
        '}';
  }

  WrongAnswerQnAEntity copyWith({
    String? id,
    String? chatRoomId,
    TopicQuestionEntity? question,
    List<String>? answers,
  }) {
    return WrongAnswerQnAEntity(
      id: id ?? this.id,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

//</editor-fold>
}
