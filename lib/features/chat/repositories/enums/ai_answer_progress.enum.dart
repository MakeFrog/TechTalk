///
/// 유저의 답변에 대한
/// 면접관(GPT) 피드백 상태
///
enum AiAnswerProgress {
  init, // 초기 상태
  onProgress, // 확인 중
  completed; // 확인 완료

  bool get isOnProgress => this == AiAnswerProgress.onProgress;
  bool get isCompleted => this == AiAnswerProgress.completed;
}
