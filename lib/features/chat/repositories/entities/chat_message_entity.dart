import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:uuid/uuid.dart';

///
/// 기본 채팅 Entity 모델 클래스
/// [ReceivedChatEntity], [AnswerChatEntity] 클래스에서 상속됨
///

abstract class BaseChatEntity {
  final String id; // ID
  final BehaviorSubject<String> message; // 채팅 메세지
  final ChatType type; // 채팅 타입
  final DateTime timestamp;
  bool isStreamApplied; // Stream 적용 여부
  final String? rootQnaId;

  BaseChatEntity({
    String? id,
    required this.message,
    required this.type,
    required this.isStreamApplied,
    required this.timestamp,
    this.rootQnaId,
  }) : id = id ?? const Uuid().v1();

  //<editor-fold desc="Data Methods">
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaseChatEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          message == other.message &&
          type == other.type &&
          timestamp == other.timestamp &&
          isStreamApplied == other.isStreamApplied);

  @override
  int get hashCode => id.hashCode ^ message.hashCode ^ type.hashCode ^ timestamp.hashCode ^ isStreamApplied.hashCode;

  @override
  String toString() {
    return 'MessageEntity{' +
        ' id: $id,' +
        ' message: $message,' +
        ' type: $type,' +
        ' timestamp: $timestamp,' +
        ' isStreamApplied: $isStreamApplied,' +
        '}';
  }
}
