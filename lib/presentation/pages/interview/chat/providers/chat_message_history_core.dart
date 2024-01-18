part of 'chat_message_history_provider.dart';

abstract class _ChatMessageHistoryCore {
  ///
  /// 초기 채팅 면접 프로세스일 경우 [ChatProgress.initial]
  /// 인트로 메세지를 생성
  ///
  Future<void> createIntroMessage();

  ///
  /// 유저 채팅 메세지 추가
  ///
  Future<void> addUserMessage(String message);

  ///
  /// 유저의 면접 질문 대답에 응답
  /// 정답 여부를 판별하고
  /// 간단한 설명을 덧붙여 피드백을 함.
  ///
  Future<void> feedbackOnUserReplayMessage(AnswerChatMessageEntity userAnswer);

  ///
  /// 면접 질문 제시
  ///
  Future<void> suggestNewQuestion();
}
