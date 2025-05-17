import 'package:techtalk/app/localization/app_locale.dart';
import 'package:intl/intl.dart';

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

// 고립된(잘못된) High Surrogate, Low Surrogate를 전부 제거하는 정규식
  static String removeInvalidSurrogates(String input) {
    final regex = RegExp(
        r'([\uD800-\uDBFF](?![\uDC00-\uDFFF]))|((?<![\uD800-\uDBFF])[\uDC00-\uDFFF])');
    return input.replaceAll(regex, '');
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

  /// 좋아요 수 & 조회수 & 구독자 수를 유튜브 포맷에 맞게 변경
  /// 1000 미만 -> 숫자 ex) 956
  /// 1000 이상 -> 천 단위 ex) 1.4천
  /// 10000 이상 -> 만 단위 ex) 32만, 이때는 소숫점 없음 && 41000 -> 4.1만
  static String? formatNumberWithUnit(int? num, {bool? isViewCount}) {
    if (num == null) {
      return null;
    }
    final strNum = '$num';
    if (num <= 1000) {
      return num.toString();
    } else if (num > 1000 && num < 10000) {
      final subString = strNum.substring(0, 2);
      final result =
          RegExp('.{1}').allMatches(subString).map((e) => e.group(0)).join('.');
      return '$result${isViewCount ?? false ? '천회' : '천'}';
      // 5 ,
    } else if (num >= 10000) {
      if (strNum.length == 5) {
        final subString = strNum.substring(0, 2);
        final result = RegExp('.{1}')
            .allMatches(subString)
            .map((e) => e.group(0))
            .join('.');
        return '$result${isViewCount ?? false ? '만회' : '만'}';
      } else {
        final result = strNum.substring(0, strNum.length - 4);
        return '$result${isViewCount ?? false ? '만회' : '만'}';
      }
    } else {
      return '-';
    }
  }

  /// 날짜를 yyyy.MM.dd 형식으로 포맷
  static String formatDateToYYYYMMDD(DateTime date) {
    return DateFormat('yyyy.MM.dd').format(date);
  }

  /// 날짜를 yyyy.MM.dd 형식의 String으로 변환 (null 처리 포함)
  static String? formatDateToYYYYMMDDNullable(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy.MM.dd').format(date);
  }

  /// String을 yyyy.MM.dd 형식의 DateTime으로 파싱 (null 처리 포함)
  static DateTime? parseYYYYMMDD(String? dateStr) {
    if (dateStr == null) return null;
    try {
      return DateFormat('yyyy.MM.dd').parse(dateStr);
    } catch (e) {
      print('날짜 파싱 실패: $dateStr - $e');
      return null;
    }
  }
}
