/** Created By Ximya - 2023.04.18
 *  Chat 문답에서 사용된는 채팅 유형을 정의
 *  1. 유저의 답변 (질문에 대한 답변) - answerQuestion
 *  2. Computer의 질문 - replyToAnswer
 *  3. 단순 공지 메세지 - alertMessage
 * */

enum ChatMessageType {
  askQuestion,
  alertMessage,
  answerQuestion,
  replyToAnswer,
}
