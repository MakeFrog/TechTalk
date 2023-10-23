import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:uuid/uuid.dart';

///
/// 기본 채팅 Entity 모델 클래스
/// [ReceivedChatEntity], [SentChatEntity] 클래스에서 상속됨
///

abstract class ChatEntity {
  final String id; // ID
  final BehaviorSubject<String> message; // 채팅 메세지
  final ChatType type; // 채팅 타입
  bool isStreamApplied; // Stream 적용 여부

  ChatEntity({
    required this.message,
    required this.type,
    required this.isStreamApplied,
  }) : id = const Uuid().v1();
}
