import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/interview_question_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/message_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/answer_state.enum.dart';

abstract interface class ChatRepository {
  /// 채팅 메세지 리스트 호출
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId);

  /// 모범답안 리스트 호출
  Future<Result<List<String>>> getIdealAnswers(
    InterviewQuestionEntity questionId,
  );

  /// 채팅방 답변 개수 업데이트
  Future<Result<void>> updateChatRoomAnswerCount(
      {required String chatRoomId, required AnswerState answerState});

  /// 채팅 메세지 업데이트
  Future<Result<void>> updateChatMessage(
      {required String chatRoomId, required List<MessageEntity> messages});

  /// 랜던 문제 호출
  Future<Result<InterviewQuestionEntity>> getRandomQuestion(String categoryId);

  /// 채팅 면접 리스트 호출
  Future<Result<List<ChatRoomEntity>>> getChatRoomList(String topicId);

  ///
  Future<Result<void>> setBasicChatRoomInfo(ChatRoomEntity chatRoomInfo);
}
