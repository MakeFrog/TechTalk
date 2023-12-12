import 'package:techtalk/features/interview_new/entities/interview_progress_info_entity.dart';
import 'package:techtalk/features/interview_new/entities/interview_topic.enum.dart';
import 'package:techtalk/features/interview_new/entities/interviewer_avatar.dart';
import 'package:techtalk/features/interview_new/entities/states/interview_progress_state.enum.dart';
import 'package:techtalk/features/interview_new/entities/states/interview_result_state.enum.dart';

class InterviewRoomEntity {
  final InterviewerAvatar interviewerInfo;
  final InterviewTopic topic;
  final InterviewProgressInfoEntity progressInfo;
  late String lastChatMessage;
  late DateTime lastChatDate;
  final String chatRoomId;

  int get completedQuestionCount =>
      progressInfo.correctAnswerCount + progressInfo.incorrectAnswerCount;

  InterviewProgressState get progressSate {
    if (progressInfo.questionCount > completedQuestionCount) {
      return InterviewProgressState.ongoing;
    } else if (progressInfo.questionCount == completedQuestionCount) {
      return InterviewProgressState.completed;
    } else {
      throw UnimplementedError('유효하지 않은 [progressState]값 입니다.');
    }
  }

  InterviewResultState get passOrFail {
    if (progressSate.isCompleted) {
      return progressInfo.correctAnswerCount >=
              progressInfo.incorrectAnswerCount
          ? InterviewResultState.pass
          : InterviewResultState.failed;
    }

    throw UnimplementedError('유효하지 않은 [passOrFail]값 입니다.');
  }

//<editor-fold desc="Data Methods">
  InterviewRoomEntity({
    required this.interviewerInfo,
    required this.topic,
    required this.progressInfo,
    required this.lastChatMessage,
    required this.lastChatDate,
    required this.chatRoomId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewRoomEntity &&
          runtimeType == other.runtimeType &&
          interviewerInfo == other.interviewerInfo &&
          topic == other.topic &&
          progressInfo == other.progressInfo &&
          lastChatMessage == other.lastChatMessage &&
          lastChatDate == other.lastChatDate &&
          chatRoomId == other.chatRoomId);

  @override
  int get hashCode =>
      interviewerInfo.hashCode ^
      topic.hashCode ^
      progressInfo.hashCode ^
      lastChatMessage.hashCode ^
      lastChatDate.hashCode ^
      chatRoomId.hashCode;

  @override
  String toString() {
    return 'InterviewRoomEntity{' +
        ' interviewerInfo: $interviewerInfo,' +
        ' topic: $topic,' +
        ' progressInfo: $progressInfo,' +
        ' lastChatMessage: $lastChatMessage,' +
        ' lastChatDate: $lastChatDate,' +
        ' chatRoomId: $chatRoomId,' +
        '}';
  }

  InterviewRoomEntity copyWith({
    InterviewerAvatar? interviewerInfo,
    InterviewTopic? topic,
    InterviewProgressInfoEntity? progressInfo,
    String? lastChatMessage,
    DateTime? lastChatDate,
    String? chatRoomId,
  }) {
    return InterviewRoomEntity(
      interviewerInfo: interviewerInfo ?? this.interviewerInfo,
      topic: topic ?? this.topic,
      progressInfo: progressInfo ?? this.progressInfo,
      lastChatMessage: lastChatMessage ?? this.lastChatMessage,
      lastChatDate: lastChatDate ?? this.lastChatDate,
      chatRoomId: chatRoomId ?? this.chatRoomId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'interviewerInfo': this.interviewerInfo,
      'topic': this.topic,
      'progressInfo': this.progressInfo,
      'lastChatMessage': this.lastChatMessage,
      'lastChatDate': this.lastChatDate,
      'chatRoomId': this.chatRoomId,
    };
  }

  factory InterviewRoomEntity.fromMap(Map<String, dynamic> map) {
    return InterviewRoomEntity(
      interviewerInfo: map['interviewerInfo'] as InterviewerAvatar,
      topic: map['topic'] as InterviewTopic,
      progressInfo: map['progressInfo'] as InterviewProgressInfoEntity,
      lastChatMessage: map['lastChatMessage'] as String,
      lastChatDate: map['lastChatDate'] as DateTime,
      chatRoomId: map['chatRoomId'] as String,
    );
  }

//</editor-fold>
}
