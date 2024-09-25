enum InterviewProgress {
  initial,
  readyToAnswer,
  interviewerReplying,
  done,
  error;

  String get fieldHintText => switch (this) {
        InterviewProgress.initial => 'interview.waitPlease',
        InterviewProgress.readyToAnswer => 'interview.provideAnswer',
        InterviewProgress.interviewerReplying => 'interview.waitPlease',
        InterviewProgress.done => 'interview.interviewEnded',
        InterviewProgress.error => 'errors.unexpectedErrorOccurred'
      };

  bool get enableChat => switch (this) {
        InterviewProgress.readyToAnswer => true,
        _ => false,
      };

  bool get canEnableTextField => switch (this) {
        InterviewProgress.readyToAnswer ||
        InterviewProgress.interviewerReplying =>
          true,
        _ => false,
      };

  bool get isDoneOrError {
    if (this == InterviewProgress.done || this == InterviewProgress.error) {
      return true;
    } else {
      return false;
    }
  }

  bool get isDone => this == InterviewProgress.done;

  bool get isInterviewerReplying =>
      this == InterviewProgress.interviewerReplying;

  bool get isError => this == InterviewProgress.error;
}
