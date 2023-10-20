import 'package:rxdart/rxdart.dart';
import 'package:techtalk/_backup/domain/enum/chat_message_type_enum.dart';
import 'package:techtalk/_backup/domain/model/chat/Correctness.dart';

class Chat {
  ChatMessageType type;
  final BehaviorSubject<String> message;
  late DateTime? sendTime;
  late Correctness correctness;

  Chat({required this.type, required this.message});

  Chat.sender(
      {required this.type,
      required this.message,
      required this.correctness,
      required this.sendTime});

  // factory Chat.userAnswer({
  //   required message,
  //   required type,
  //   required sendTime,
  // }) {
  //   return Chat(
  //       type: type,
  //       message: message,
  //       sendTime: sendTime,
  //       correct: Correctness.checking);
  // }

  static List<Chat> generate() {
    return [
      Chat(
        type: ChatMessageType.alertMessage,
        message: BehaviorSubject.seeded("안녕하세요. Swift 개발 면접 질문을 드리겠습니다."),
      )
    ].reversed.toList();
  }
}
