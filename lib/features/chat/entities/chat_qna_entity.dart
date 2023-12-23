import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatQnaEntity {
  final String id; // 질문 Id
  final TopicQnaEntity question;
  final AnswerChatMessageEntity? answer; // 유저 응답
  bool get hasUserResponded => answer != null;

//<editor-fold desc="Data Methods">
  const ChatQnaEntity({
    required this.id,
    required this.question,
    this.answer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatQnaEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answer == other.answer);

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answer.hashCode;

  @override
  String toString() {
    return 'InterviewQnAEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        ' answer: $answer,' +
        '}';
  }

  ChatQnaEntity copyWith({
    String? id,
    TopicQnaEntity? question,
    AnswerChatMessageEntity? answer,
  }) {
    return ChatQnaEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

//</editor-fold>
}
