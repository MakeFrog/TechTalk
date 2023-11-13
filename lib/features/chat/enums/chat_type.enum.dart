///
/// 채팅 유형
///
enum ChatType {
  userReply, // 유저 응답
  guide, // 일반 가이드 텍스트
  feedback, // 유저의 면답 답변을 대합 대답
  askQuestion; // 유저에게 물어보는 면접 질문

  bool get isSentMessage => this == ChatType.userReply;
  bool get isReceivedMessage => this != ChatType.userReply;
  bool get isAskQuestionMessage => this == ChatType.askQuestion;
  bool get isFeedbackMessage => this == ChatType.feedback;
}
