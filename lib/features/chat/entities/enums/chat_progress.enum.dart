///
/// 면접(채팅방) 진행상태
///
enum ChatProgress {
  initial,
  ongoing,
  completed;

  bool get isInitial => this == ChatProgress.initial;
  bool get isOngoing => this == ChatProgress.ongoing;
  bool get isCompleted => this == ChatProgress.completed;
}
