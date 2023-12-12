enum InterviewResultState {
  pass,
  failed;

  bool get isPassed => this == InterviewResultState.pass;
}
