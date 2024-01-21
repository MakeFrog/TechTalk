///
/// 면접(채팅방) 진행상태
///
enum ChatRoomProgress {
  initial,
  ongoing,
  completed;

  bool get isInitial => this == ChatRoomProgress.initial;
  bool get isOngoing => this == ChatRoomProgress.ongoing;
  bool get isCompleted => this == ChatRoomProgress.completed;
  bool get isOnGoingOrCompleted =>
      this == ChatRoomProgress.ongoing || this == ChatRoomProgress.completed;
}
