import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatRoomEntity {
  final InterviewerAvatar interviewerInfo;
  final Topic topic;
  final ChatQnaProgressInfoEntity qnaProgressInfo;
  late String lastChatMessage;
  late DateTime lastChatDate;
  final String chatRoomId;

  ChatRoomEntity({
    required this.interviewerInfo,
    required this.topic,
    required this.chatRoomId,
    required this.lastChatDate,
    required this.lastChatMessage,
    required this.qnaProgressInfo,
  });

  int get completedQuestionCount =>
      qnaProgressInfo.correctAnswerCount + qnaProgressInfo.incorrectAnswerCount;

  InterviewProgressState get progressSate {
    if (qnaProgressInfo.totalQuestionCount > completedQuestionCount) {
      return InterviewProgressState.ongoing;
    } else if (qnaProgressInfo.totalQuestionCount == completedQuestionCount) {
      return InterviewProgressState.completed;
    } else {
      throw UnimplementedError('유효하지 않은 [progressState]값 입니다.');
    }
  }

  PassOrFail get passOrFail {
    if (qnaProgressInfo.correctAnswerCount >=
            qnaProgressInfo.incorrectAnswerCount &&
        progressSate.isCompleted) {
      return PassOrFail.pass;
    } else if (qnaProgressInfo.correctAnswerCount <
            qnaProgressInfo.incorrectAnswerCount &&
        progressSate.isCompleted) {
      return PassOrFail.failed;
    } else {
      throw UnimplementedError('유효하지 않은 [passOrFail]값 입니다.');
    }
  }

  factory ChatRoomEntity.fromFireStore(
      {required ChatRoomModel chatRoom, required MessageModel message}) {
    return ChatRoomEntity(
      interviewerInfo: InterviewerAvatar.getAvatarInfoById(
        chatRoom.interviewerId,
      ),
      qnaProgressInfo: ChatQnaProgressInfoEntity(
        totalQuestionCount: chatRoom.totalQuestionCount,
        correctAnswerCount: chatRoom.correctAnswerCount,
        incorrectAnswerCount: chatRoom.incorrectAnswerCount,
      ),
      topic: Topic.getTopicById(chatRoom.topicId),
      chatRoomId: chatRoom.chatRoomId,
      lastChatDate: message.timestamp,
      lastChatMessage: message.message,
    );
  }
}
