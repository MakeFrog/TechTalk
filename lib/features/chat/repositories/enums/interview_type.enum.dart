enum InterviewType {
  singleTopic,
  practical;

  bool get isSingleTopic => this == InterviewType.singleTopic;
  bool get isPractical => this == InterviewType.practical;
}
