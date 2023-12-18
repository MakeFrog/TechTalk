import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatRoomEntity {
  final InterviewerAvatar interviewerInfo;
  final Topic topic;
  final ChatQnaProgressInfoEntity qnaProgressInfo;
  final String? lastChatMessage;
  final DateTime? lastChatDate;
  final String chatRoomId;

  int get completedQuestionCount => qnaProgressInfo.completedQuestionCount;

  InterviewProgressState get progressState => qnaProgressInfo.progressState;

  PassOrFail get passOrFail => qnaProgressInfo.passOrFail;

//<editor-fold desc="Data Methods">
  ChatRoomEntity({
    required this.interviewerInfo,
    required this.topic,
    required this.qnaProgressInfo,
    this.lastChatMessage,
    this.lastChatDate,
    required this.chatRoomId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRoomEntity &&
          runtimeType == other.runtimeType &&
          interviewerInfo == other.interviewerInfo &&
          topic == other.topic &&
          qnaProgressInfo == other.qnaProgressInfo &&
          lastChatMessage == other.lastChatMessage &&
          lastChatDate == other.lastChatDate &&
          chatRoomId == other.chatRoomId);

  @override
  int get hashCode =>
      interviewerInfo.hashCode ^
      topic.hashCode ^
      qnaProgressInfo.hashCode ^
      lastChatMessage.hashCode ^
      lastChatDate.hashCode ^
      chatRoomId.hashCode;

  @override
  String toString() {
    return 'ChatRoomEntity{' +
        ' interviewerInfo: $interviewerInfo,' +
        ' topic: $topic,' +
        ' qnaProgressInfo: $qnaProgressInfo,' +
        ' lastChatMessage: $lastChatMessage,' +
        ' lastChatDate: $lastChatDate,' +
        ' chatRoomId: $chatRoomId,' +
        '}';
  }

  ChatRoomEntity copyWith({
    InterviewerAvatar? interviewerInfo,
    Topic? topic,
    ChatQnaProgressInfoEntity? qnaProgressInfo,
    String? lastChatMessage,
    DateTime? lastChatDate,
    String? chatRoomId,
  }) {
    return ChatRoomEntity(
      interviewerInfo: interviewerInfo ?? this.interviewerInfo,
      topic: topic ?? this.topic,
      qnaProgressInfo: qnaProgressInfo ?? this.qnaProgressInfo,
      lastChatMessage: lastChatMessage ?? this.lastChatMessage,
      lastChatDate: lastChatDate ?? this.lastChatDate,
      chatRoomId: chatRoomId ?? this.chatRoomId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'interviewerInfo': this.interviewerInfo,
      'topic': this.topic,
      'qnaProgressInfo': this.qnaProgressInfo,
      'lastChatMessage': this.lastChatMessage,
      'lastChatDate': this.lastChatDate,
      'chatRoomId': this.chatRoomId,
    };
  }

  factory ChatRoomEntity.fromMap(Map<String, dynamic> map) {
    return ChatRoomEntity(
      interviewerInfo: map['interviewerInfo'] as InterviewerAvatar,
      topic: map['topic'] as Topic,
      qnaProgressInfo: map['qnaProgressInfo'] as ChatQnaProgressInfoEntity,
      lastChatMessage: map['lastChatMessage'] as String,
      lastChatDate: map['lastChatDate'] as DateTime,
      chatRoomId: map['chatRoomId'] as String,
    );
  }

//</editor-fold>
}
