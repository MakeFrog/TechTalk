import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';

class ChatRoomListItemEntity {
  final InterviewerAvatar interviewerInfo;
  final InterviewTopic topic;
  late String lastChatMessage;
  late DateTime lastChatDate;
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;
  final String chatRoomId;

  ChatRoomListItemEntity({
    required this.interviewerInfo,
    required this.topic,
    required this.chatRoomId,
    required this.lastChatDate,
    required this.lastChatMessage,
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  int get completedQuestionCount => correctAnswerCount + incorrectAnswerCount;

  InterviewProgressState get progressSate {
    if (totalQuestionCount > completedQuestionCount) {
      return InterviewProgressState.ongoing;
    } else if (totalQuestionCount == completedQuestionCount) {
      return InterviewProgressState.completed;
    } else {
      throw UnimplementedError('유효하지 않은 [progressState]값 입니다.');
    }
  }

  PassOrFail get passOrFail {
    if (correctAnswerCount >= incorrectAnswerCount &&
        progressSate.isCompleted) {
      return PassOrFail.pass;
    } else if (correctAnswerCount < incorrectAnswerCount &&
        progressSate.isCompleted) {
      return PassOrFail.failed;
    } else {
      throw UnimplementedError('유효하지 않은 [passOrFail]값 입니다.');
    }
  }

  factory ChatRoomListItemEntity.fromFireStore(
      {required ChatRoomModel chatRoom, required MessageModel message}) {
    return ChatRoomListItemEntity(
      interviewerInfo: InterviewerAvatar.getAvatarInfoById(
        chatRoom.interviewerId,
      ),
      topic: InterviewTopic.getTopicById(chatRoom.topicId),
      chatRoomId: chatRoom.chatRoomId,
      totalQuestionCount: chatRoom.totalQuestionCount,
      correctAnswerCount: chatRoom.correctAnswerCount,
      incorrectAnswerCount: chatRoom.incorrectAnswerCount,
      lastChatDate: message.timestamp,
      lastChatMessage: message.message,
    );
  }
}
