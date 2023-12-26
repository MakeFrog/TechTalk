///
/// 채팅 유형
///
enum ChatType {
  userReply('sent'), // 유저 응답
  guide('guide'), // 일반 가이드 텍스트
  feedback('feedback'), // 유저의 면답 답변을 대합 대답
  askQuestion('question'); // 유저에게 물어보는 면접 질문

  final String id;

  const ChatType(this.id);

  bool get isSentMessage => this == ChatType.userReply;
  bool get isReceivedMessage => this != ChatType.userReply;
  bool get isAskQuestionMessage => this == ChatType.askQuestion;
  bool get isFeedbackMessage => this == ChatType.feedback;
  bool get isGuideMessage => this == ChatType.guide;

  static ChatType getTypeById(String id) {
    return values.firstWhere(
      (type) => type.id == id,
      orElse: () => throw Exception('Unexpected Question Id Value'),
    );
  }
}
