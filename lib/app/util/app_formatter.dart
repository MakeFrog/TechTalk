abstract final class AppFormatter {
  /// 영싱 시간 formatter
  static String formatDuration(Duration duration) {
    // 시, 분, 초 계산
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      // HH:mm:ss 형식
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      // mm:ss 형식
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
