import 'package:techtalk/app/localization/app_locale.dart';

abstract final class AppFormatter {
  /// 영싱 시간 formatter
  static String formatDurationTommssOrHHmmss(Duration duration) {
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

  ///
  /// 시분 형태로 고정된 포맷
  /// 00 : 00 : 00
  ///
  static String formatDurationToHHmm(Duration duration) {
    // 분과 초를 계산
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;

    // 두 자리 문자열로 포맷
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }

  ///
  /// 언어에 맞게 시,분,초 형태로 duration을 폴맷
  ///
  static String formatDurationLanguageFormat(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (AppLocale.isKo) {
      // 한국어 형식
      if (hours > 0) {
        return '$hours시간 $minutes분 $seconds초';
      } else if (minutes > 0) {
        return '$minutes분 $seconds초';
      } else {
        return '$seconds초';
      }
    } else {
      // 영어 형식
      if (hours > 0) {
        return '$hours hour${hours > 1 ? 's' : ''} $minutes minute${minutes > 1 ? 's' : ''} $seconds second${seconds > 1 ? 's' : ''}';
      } else if (minutes > 0) {
        return '$minutes minute${minutes > 1 ? 's' : ''} $seconds second${seconds > 1 ? 's' : ''}';
      } else {
        return '$seconds second${seconds > 1 ? 's' : ''}';
      }
    }
  }
}
