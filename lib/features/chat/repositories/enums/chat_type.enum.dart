///
/// 채팅 유형
///
enum ChatType {
  reply, // 유저 응답
  guide, // 일반 가이드 텍스트
  feedback, // 유저의 면답 답변을 대합 대답
  question; // 유저에게 물어보는 면접 질문

  bool get isSentMessage => this == ChatType.reply;
  bool get isReceivedMessage => this != ChatType.reply;
  bool get isQuestionMessage => this == ChatType.question;
  bool get isFeedbackMessage => this == ChatType.feedback;
  bool get isGuideMessage => this == ChatType.guide;

  static ChatType getTypeById(String id) {
    return values.firstWhere(
      (type) => type.name == id,
      orElse: () => throw Exception('Unexpected Question Id Value'),
    );
  }
}
