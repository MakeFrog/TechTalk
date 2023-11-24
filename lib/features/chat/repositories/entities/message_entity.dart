import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:uuid/uuid.dart';

///
/// 기본 채팅 Entity 모델 클래스
/// [ReceivedChatEntity], [SentMessageEntity] 클래스에서 상속됨
///

abstract class MessageEntity {
  final String id; // ID
  final BehaviorSubject<String> message; // 채팅 메세지
  final ChatType type; // 채팅 타입
  final DateTime timestamp;
  bool isStreamApplied; // Stream 적용 여부

  MessageEntity({
    required this.message,
    required this.type,
    required this.isStreamApplied,
    required this.timestamp,
  }) : id = const Uuid().v1();

  factory MessageEntity.fromModel(MessageModel model) {
    final chatType = ChatType.getTypeById(model.type);
    switch (chatType) {
      case ChatType.guide:
        return GuideMessageEntity.createStatic(
          message: model.message,
          timestamp: model.timestamp,
        );

      case ChatType.userReply:
        return SentMessageEntity(
          message: model.message,
          answerState: AnswerState.getStateById(model.qna!['state']!),
          timestamp: model.timestamp,
          questionId: model.qna!['questionId']!,
        );
      case ChatType.askQuestion:
        return QuestionMessageEntity.createStaticChat(
          questionId: model.qna!['questionId']!,
          timestamp: model.timestamp,
          idealAnswers: List<String>.from(model.qna!['idealAnswers']!),
          message: model.message,
        );

      case ChatType.feedback:
        return FeedbackMessageEntity.createStatic(
          message: model.message,
          timestamp: model.timestamp,
        );

      default:
        throw Exception('Unexpected type id value');
    }
  }
}
