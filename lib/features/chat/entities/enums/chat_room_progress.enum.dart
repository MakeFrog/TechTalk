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

  R branch<R>({
    required R Function() initial,
    required R Function() ongoing,
    required R Function() completed,
  }) {
    switch (this) {
      case ChatRoomProgress.initial:
        return initial();
      case ChatRoomProgress.ongoing:
        return ongoing();
      case ChatRoomProgress.completed:
        return completed();
      default:
        throw Exception('잘못된 enum 값: $branch');
    }
  }
}
