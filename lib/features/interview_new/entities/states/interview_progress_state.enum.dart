///
/// 면접(채팅방) 진행상태
///
enum InterviewProgressState {
  initial,
  ongoing,
  completed;

  bool get isInitial => this == InterviewProgressState.initial;
  bool get isOngoing => this == InterviewProgressState.ongoing;
  bool get isCompleted => this == InterviewProgressState.completed;
}
