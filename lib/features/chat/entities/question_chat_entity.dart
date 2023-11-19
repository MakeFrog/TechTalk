import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class QuestionChatEntity extends ChatEntity {
  final String questionId;
  final List<String> idealAnswers;

  QuestionChatEntity(
      {required this.questionId,
      required this.idealAnswers,
      required BehaviorSubject<String> message,
      required bool isStreamApplied})
      : super(
          type: ChatType.askQuestion,
          message: message,
          isStreamApplied: isStreamApplied,
        );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionChatEntity.createStaticChat({
    required String questionId,
    required List<String> idealAnswers,
    required String message,
  }) =>
      QuestionChatEntity(
        questionId: questionId,
        idealAnswers: idealAnswers,
        message: BehaviorSubject.seeded(message)..close(),
        isStreamApplied: false,
      );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionChatEntity.createStreamedChat({
    required String questionId,
    required List<String> idealAnswers,
    required BehaviorSubject<String> streamedMessage,
  }) =>
      QuestionChatEntity(
        questionId: questionId,
        idealAnswers: idealAnswers,
        message: streamedMessage,
        isStreamApplied: true,
      );
}
