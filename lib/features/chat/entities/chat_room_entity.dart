import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/entities/chat_progress_info_entity.dart';
import 'package:techtalk/features/chat/entities/interviewer_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatRoomEntity {
  final String id;
  final InterviewerEntity interviewer;
  final TopicEntity topic;
  final ChatProgressInfoEntity progressInfo;
  final String? lastChatMessage;
  final DateTime? lastChatDate;

  int get completedQuestionCount => progressInfo.completedQuestionCount;
  ChatProgress get progressState => progressInfo.progressState;
  ChatResult get passOrFail => progressInfo.chatResult;

  factory ChatRoomEntity.random({
    required TopicEntity topic,
    required int questionCount,
  }) {
    return ChatRoomEntity(
      id: StringGenerator.generateRandomString(),
      interviewer: InterviewerEntity.getRandomInterviewer(),
      topic: topic,
      progressInfo: ChatProgressInfoEntity.onInitial(
        totalQuestionCount: questionCount,
      ),
    );
  }

//<editor-fold desc="Data Methods">
  const ChatRoomEntity({
    required this.id,
    required this.interviewer,
    required this.topic,
    required this.progressInfo,
    this.lastChatMessage,
    this.lastChatDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRoomEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          interviewer == other.interviewer &&
          topic == other.topic &&
          progressInfo == other.progressInfo &&
          lastChatMessage == other.lastChatMessage &&
          lastChatDate == other.lastChatDate);

  @override
  int get hashCode =>
      id.hashCode ^
      interviewer.hashCode ^
      topic.hashCode ^
      progressInfo.hashCode ^
      lastChatMessage.hashCode ^
      lastChatDate.hashCode;

  @override
  String toString() {
    return 'ChatRoomEntity{' +
        ' id: $id,' +
        ' interviewer: $interviewer,' +
        ' topic: $topic,' +
        ' progressInfo: $progressInfo,' +
        ' lastChatMessage: $lastChatMessage,' +
        ' lastChatDate: $lastChatDate,' +
        '}';
  }

  ChatRoomEntity copyWith({
    String? id,
    InterviewerEntity? interviewer,
    TopicEntity? topic,
    ChatProgressInfoEntity? progressInfo,
    String? lastChatMessage,
    DateTime? lastChatDate,
  }) {
    return ChatRoomEntity(
      id: id ?? this.id,
      interviewer: interviewer ?? this.interviewer,
      topic: topic ?? this.topic,
      progressInfo: progressInfo ?? this.progressInfo,
      lastChatMessage: lastChatMessage ?? this.lastChatMessage,
      lastChatDate: lastChatDate ?? this.lastChatDate,
    );
  }
//</editor-fold>
}
