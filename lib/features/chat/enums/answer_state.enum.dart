///
/// 유저의 면접 질문 답변 상태
///
enum AnswerState {
  loading('[l]'),
  correct('[c]'),
  wrong('[w]');

  final String tag;

  const AnswerState(this.tag);

  bool get isLoading => this == AnswerState.loading;
  bool get isCorrect => this == AnswerState.correct;
  bool get isWrong => this == AnswerState.wrong;
}
