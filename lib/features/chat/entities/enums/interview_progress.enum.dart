enum InterviewProgress {
  initial,
  readyToAnswer,
  interviewerReplying,
  done;

  String get fieldHintText => switch (this) {
        InterviewProgress.initial => '잠시만 기다려주세요',
        InterviewProgress.readyToAnswer => '답변을 입력해주세요',
        InterviewProgress.interviewerReplying => '잠시만 기다려주세요',
        InterviewProgress.done => '면접이 종료되었습니다',
      };

  bool get enableChat => switch (this) {
        InterviewProgress.initial => false,
        InterviewProgress.readyToAnswer => true,
        InterviewProgress.interviewerReplying => false,
        InterviewProgress.done => false,
      };
}
