import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/entities/received_chat_entity.dart';
import 'package:techtalk/features/chat/entities/sent_chat_entity.dart';
import 'package:techtalk/features/chat/enums/answer_state.enum.dart';
import 'package:techtalk/features/chat/enums/chat_type.enum.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';

final class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Result<List<ChatEntity>>> getChatList(String roomId) async {
    final List<ChatEntity> result = [
      ReceivedChatEntity.createStaticChat(
        message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요.',
        type: ChatType.askQuestion,
      ),
      ReceivedChatEntity.createStaticChat(
        message: '다음 문제 입니다',
        type: ChatType.guide,
      ),
      ReceivedChatEntity.createStaticChat(
        message:
            'Swift에서 upcasting과 downcasting의 개념을 이해 하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.\nupcasting은 서로 상속 관계에 있는 클래스에서 자식 클래스를 부모 클래스로 타입캐스팅 하는 것이 맞습니다.',
        type: ChatType.replyToUserAnswer,
      ),
      SentChatEntity(
        message:
            '서로 상속 관계에 있는 클래스에서 자식 클래스를 부모 클래스로 타입 캐스팅 하는 것을 업 캐스팅이라고 하고, as를 사용해서 업 캐스팅할 수 있습니다.',
        answerState: AnswerState.correct,
      ),
      ReceivedChatEntity.createStaticChat(
        message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요',
        type: ChatType.askQuestion,
      ),
      ReceivedChatEntity.createStaticChat(
        message: '반가워요! 지혜님. Swift 면접 질문을 드리겠습니다.',
        type: ChatType.guide,
      ),
    ];

    return Result.success(result);
  }
}
