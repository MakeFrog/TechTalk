

import 'dart:async';

import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';
import 'package:rxdart/rxdart.dart';

class Chat {
  ChatMessageType type;
  final BehaviorSubject<String> message;

  Chat({required this.type, required this.message});

  static List<Chat> generate() {
    return [
      Chat(
        type: ChatMessageType.alertMessage,
        message: BehaviorSubject.seeded("안녕하세요"),
      ),
      Chat(
        type: ChatMessageType.askQuestion,
        message: BehaviorSubject.seeded("안녕하세요22"),
      ),
    ].reversed.toList();
  }
}
