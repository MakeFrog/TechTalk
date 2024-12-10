import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatRoomEntity {
  final InterviewType type;
  final String id;
  final Interviewer interviewer;
  final List<TopicEntity> topics;
  final ChatProgressInfoEntity progressInfo;
  final String? lastChatMessage;
  final DateTime? lastChatDate;
  final bool isTemporary;
  final List<String>? qnaIds;

  const ChatRoomEntity({
    required this.type,
    required this.id,
    required this.interviewer,
    required this.topics,
    required this.progressInfo,
    this.qnaIds,
    this.lastChatMessage,
    this.lastChatDate,
    this.isTemporary = false,
  });

  ChatRoomProgress get progressState {
    final totalQnaCount = progressInfo.totalQuestionCount;
    final completedCount = progressInfo.completedQuestionCount;

    if (totalQnaCount == completedCount) {
      return ChatRoomProgress.completed;
    } else if (completedQuestionCount == 0 && lastChatMessage == null) {
      return ChatRoomProgress.initial;
    } else {
      return ChatRoomProgress.ongoing;
    }
  }

  int get completedQuestionCount => progressInfo.completedQuestionCount;

  InterviewResult get interviewResult {
    if (progressState.isCompleted) {
      if (progressInfo.correctAnswerCount >=
          progressInfo.incorrectAnswerCount) {
        return InterviewResult.pass;
      } else if (progressInfo.correctAnswerCount <
          progressInfo.incorrectAnswerCount) {
        return InterviewResult.failed;
      } else {
        throw UnimplementedError('유효하지 않은 [passOrFail]값 입니다.');
      }
    } else {
      throw UnimplementedError('진행도가 완료되지 않았습니다 : $progressState');
    }
  }

  InterviewResult get passOrFail => interviewResult;

  TopicEntity get singleTopic => topics.first;

  factory ChatRoomEntity.random({
    required InterviewType type,
    required List<TopicEntity> topics,
    required int questionCount,
  }) {
    return ChatRoomEntity(
      isTemporary: true,
      type: type,
      id: StringGenerator.generateRandomString(),
      interviewer: Interviewer.getRandomInterviewer(),
      topics: topics,
      progressInfo: ChatProgressInfoEntity.onInitial(
        totalQuestionCount: questionCount,
      ),
    );
  }

  factory ChatRoomEntity.fromModel(ChatRoomModel roomModel) {
    final topics = switch (roomModel.type) {
      InterviewType.commonSingleTopic => [
          StoredTopics.getById(roomModel.topicIds.first)
        ],
      InterviewType.commonPracticalTopic =>
        roomModel.topicIds.map(StoredTopics.getById).toList(),
      InterviewType.resume => throw Exception('타입을 지정해주어야 합니다'),
    };

    final progress = roomModel.totalQuestionCount ==
            roomModel.correctAnswerCount + roomModel.incorrectAnswerCount
        ? ChatRoomProgress.completed
        : ChatRoomProgress.ongoing;

    return ChatRoomEntity(
      type: roomModel.type,
      id: roomModel.id,
      interviewer: Interviewer.getAvatarInfoById(roomModel.interviewerId),
      topics: topics,
      progressInfo: ChatProgressInfoEntity(
        totalQuestionCount: roomModel.totalQuestionCount,
        correctAnswerCount: roomModel.correctAnswerCount,
        incorrectAnswerCount: roomModel.incorrectAnswerCount,
      ),
    );
  }

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
    Interviewer? interviewer,
    List<TopicEntity>? topics,
    ChatProgressInfoEntity? progressInfo,
    String? lastChatMessage,
    DateTime? lastChatDate,
    ChatRoomProgress? chatProgressState,
    bool? isTemporary,
    List<String>? qnaIds,
  }) {
    return ChatRoomEntity(
      id: id ?? this.id,
      type: type,
      interviewer: interviewer ?? this.interviewer,
      topics: topics ?? this.topics,
      qnaIds: qnaIds ?? this.qnaIds,
      progressInfo: progressInfo ?? this.progressInfo,
      lastChatMessage: lastChatMessage ?? this.lastChatMessage,
      lastChatDate: lastChatDate ?? this.lastChatDate,
      isTemporary: isTemporary ?? this.isTemporary,
    );
  }

//</editor-fold>
}
