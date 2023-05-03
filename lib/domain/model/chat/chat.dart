import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';

class Chat {
  final ChatMessageType type;
  final String message;

  Chat({required this.type, required this.message});

  static List<Chat> generate() {
    return [
      Chat(
          type: ChatMessageType.askQuestion,
          message: "Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요."),
      Chat(
        type: ChatMessageType.answerQuestion,
        message:
            "서로 상속 관계에 있는 클래스에서 자식 클래스를 부모 클래스로 타입캐스팅 하는 것을 업 캐스팅이라고 하고 as를 사용해서 업 캐스팅할 수 있습니다.",
      ),
      Chat(
        type: ChatMessageType.replyToAnswer,
        message:
            "오답입니다\n Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.",
      ),
    ].reversed.toList();
  }
}
