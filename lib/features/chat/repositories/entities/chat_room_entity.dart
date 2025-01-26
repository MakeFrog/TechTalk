import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
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

  /// [InterviewType.resume]
  final List<BaseQnaEntity> qnas;

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
    this.qnas = const [],
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

  /// 단골 면접 질문
  factory ChatRoomEntity.generateCommonInterview({
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

  /// 이력서 면접 질문
  factory ChatRoomEntity.generateResumeInterview({
    required List<ResumeQnaEntity> qnas,
  }) {
    return ChatRoomEntity(
      isTemporary: true,
      type: InterviewType.resume,
      id: StringGenerator.generateRandomString(),
      interviewer: Interviewer.getRandomInterviewer(),
      qnas: qnas,
      topics: [],
      progressInfo: ChatProgressInfoEntity.onInitial(
        totalQuestionCount: qnas.length,
      ),
    );
  }

  /// 이력서 면접 질문
  factory ChatRoomEntity.generateYoutubeInterview({
    required List<YoutubeQnaEntity> qnas,
  }) {
    return ChatRoomEntity(
      isTemporary: true,
      type: InterviewType.youtube,
      id: StringGenerator.generateRandomString(),
      interviewer: Interviewer.getRandomInterviewer(),
      qnas: qnas,
      topics: [],
      progressInfo: ChatProgressInfoEntity.onInitial(
        totalQuestionCount: qnas.length,
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
      InterviewType.resume => <TopicEntity>[],
      InterviewType.youtube => <TopicEntity>[],
    };

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
      other is ChatRoomEntity &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          id == other.id &&
          interviewer == other.interviewer &&
          topics == other.topics &&
          progressInfo == other.progressInfo &&
          lastChatMessage == other.lastChatMessage &&
          lastChatDate == other.lastChatDate &&
          isTemporary == other.isTemporary &&
          qnaIds == other.qnaIds &&
          qnas == other.qnas;

  @override
  int get hashCode =>
      type.hashCode ^
      id.hashCode ^
      interviewer.hashCode ^
      topics.hashCode ^
      progressInfo.hashCode ^
      lastChatMessage.hashCode ^
      lastChatDate.hashCode ^
      isTemporary.hashCode ^
      qnaIds.hashCode ^
      qnas.hashCode;

  ChatRoomEntity copyWith({
    InterviewType? type,
    String? id,
    Interviewer? interviewer,
    List<TopicEntity>? topics,
    ChatProgressInfoEntity? progressInfo,
    String? lastChatMessage,
    DateTime? lastChatDate,
    bool? isTemporary,
    List<String>? qnaIds,
    List<BaseQnaEntity>? qnas,
  }) {
    return ChatRoomEntity(
      type: type ?? this.type,
      id: id ?? this.id,
      interviewer: interviewer ?? this.interviewer,
      topics: topics ?? this.topics,
      progressInfo: progressInfo ?? this.progressInfo,
      lastChatMessage: lastChatMessage ?? this.lastChatMessage,
      lastChatDate: lastChatDate ?? this.lastChatDate,
      isTemporary: isTemporary ?? this.isTemporary,
      qnaIds: qnaIds ?? this.qnaIds,
      qnas: qnas ?? this.qnas,
    );
  }
}
