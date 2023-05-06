/** Created By Ximya - 2023.04.18
 *  Chat 문답에서 사용된는 채팅 유형을 정의
 *  1. (컴퓨터) 질문 제시 - askQuestion
 *  2. (컴퓨터) 일반 공지 메세지 - alertMessage
 *  3. (컴퓨터) 유저의 답변에 대한 정답 확인 - replyToAnswer
 *  4. (유저) 질문에 대한 유저의 답변 - answerQuestion
 * */

enum ChatMessageType {
  askQuestion,
  alertMessage,
  answerQuestion,
  replyToUserAnswer,
}

extension ChatMessageTypeExtension on ChatMessageType {
  bool get isReceiverType {
    if (this != ChatMessageType.answerQuestion) {
      return true;
    } else {
      return false;
    }
  }

  bool get isStreamFormat {
    switch (this) {
      case ChatMessageType.askQuestion:
        return true;
      case ChatMessageType.alertMessage:
        return false;
      case ChatMessageType.replyToUserAnswer:
        return true;
      case ChatMessageType.answerQuestion:
        return false;
    }
  }
}
