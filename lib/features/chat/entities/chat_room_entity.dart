import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/entities/chat_progress_info_entity.dart';
import 'package:techtalk/features/chat/entities/interviewer_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatRoomEntity {
  final InterviewType type;
  final String id;
  final InterviewerEntity interviewer;
  final List<TopicEntity> topics;
  final ChatProgressInfoEntity progressInfo;
  final String? lastChatMessage;
  final DateTime? lastChatDate;
  final bool isTemporary;

  int get completedQuestionCount => progressInfo.completedQuestionCount;
  ChatProgress get progressState => progressInfo.progressState;
  ChatResult get passOrFail => progressInfo.chatResult;

  factory ChatRoomEntity.random({
    required InterviewType type,
    required List<TopicEntity> topics,
    required int questionCount,
  }) {
    return ChatRoomEntity(
      isTemporary: true,
      type: type,
      id: StringGenerator.generateRandomString(),
      interviewer: InterviewerEntity.getRandomInterviewer(),
      topics: topics,
      progressInfo: ChatProgressInfoEntity.onInitial(
        totalQuestionCount: questionCount,
      ),
    );
  }

//<editor-fold desc="Data Methods">
  const ChatRoomEntity({
    required this.type,
    required this.id,
    required this.interviewer,
    required this.topics,
    required this.progressInfo,
    this.lastChatMessage,
    this.lastChatDate,
    this.isTemporary = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRoomEntity &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          id == other.id &&
          interviewer == other.interviewer &&
          topics == other.topics &&
          progressInfo == other.progressInfo &&
          lastChatMessage == other.lastChatMessage &&
          lastChatDate == other.lastChatDate &&
          isTemporary == other.isTemporary);

  @override
  int get hashCode =>
      type.hashCode ^
      id.hashCode ^
      interviewer.hashCode ^
      topics.hashCode ^
      progressInfo.hashCode ^
      lastChatMessage.hashCode ^
      lastChatDate.hashCode ^
      isTemporary.hashCode;

  @override
  String toString() {
    return 'ChatRoomEntity{' +
        ' type: $type,' +
        ' id: $id,' +
        ' interviewer: $interviewer,' +
        ' topics: $topics,' +
        ' progressInfo: $progressInfo,' +
        ' lastChatMessage: $lastChatMessage,' +
        ' lastChatDate: $lastChatDate,' +
        ' isTemporary: $isTemporary,' +
        '}';
  }

  ChatRoomEntity copyWith({
    String? id,
    InterviewerEntity? interviewer,
    List<TopicEntity>? topics,
    ChatProgressInfoEntity? progressInfo,
    String? lastChatMessage,
    DateTime? lastChatDate,
    bool? isTemporary,
  }) {
    return ChatRoomEntity(
      id: id ?? this.id,
      type: type,
      interviewer: interviewer ?? this.interviewer,
      topics: topics ?? this.topics,
      progressInfo: progressInfo ?? this.progressInfo,
      lastChatMessage: lastChatMessage ?? this.lastChatMessage,
      lastChatDate: lastChatDate ?? this.lastChatDate,
      isTemporary: isTemporary ?? this.isTemporary,
    );
  }

//</editor-fold>
}
