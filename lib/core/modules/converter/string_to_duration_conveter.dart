import 'package:json_annotation/json_annotation.dart';

/// 문자열을 Duration으로, Duration을 문자열로 변환하는 JsonConverter
/// 문자열 형식: HH:mm:ss.SSSSSS
class StringToDurationConveter implements JsonConverter<Duration?, String?> {
  const StringToDurationConveter();

  /// JSON 문자열을 [Duration]으로 변환
  @override
  Duration? fromJson(String? durationString) {
    if (durationString == null) return null;

    // :로 구분된 문자열을 분리
    final components = durationString.split(':');

    if (components.length != 3 && components.length != 4) {
      throw FormatException(
          'Invalid duration format. Expected HH:mm:ss or HH:mm:ss.SSSSSS.');
    }

    final hours = int.tryParse(components[0]) ?? 0;
    final minutes = int.tryParse(components[1]) ?? 0;
    final secondsAndMilliseconds = components[2].split('.');

    final seconds = int.tryParse(secondsAndMilliseconds[0]) ?? 0;
    int microseconds = 0;

    if (secondsAndMilliseconds.length == 2) {
      // 밀리초가 있다면, 초 값에 맞는 밀리초 계산
      final microsecondsVal =
          (double.tryParse('0.' + secondsAndMilliseconds[1]) ?? 0) * 1000000;
      microseconds = microsecondsVal.toInt();
    }

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      microseconds: microseconds,
    );
  }

  /// [Duration] 객체를 JSON 문자열로 변환
  @override
  String? toJson(Duration? duration) {
    if (duration == null) return null;

    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }
}
