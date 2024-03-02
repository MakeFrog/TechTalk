import 'package:intl/intl.dart';

extension KoreaDateTimeExt on DateTime {
  /// 년도.월.일 형식의 String으로 반환한다.
  ///
  /// 예를 들어, '2023년 8월 10일'의 경우 '23.08.10'으로 반환한다.
  String get formatyyMMdd {
    return DateFormat('yy.MM.dd').format(this);
  }

  ///
  /// 주어진 dateTime 비교되는 dateTime과 동일하거나 이후인지 판단하는 메소드
  ///
  bool isAfterOrSameAs(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }

  ///
  /// 주어진 datetime이 한달 이상 지났느지 확인하는 메소드
  ///
  bool get isOneMonthOrMorePassedFromNow {
    DateTime now = DateTime.now();

    Duration difference = now.difference(this);

    double differenceInMonths = difference.inDays / 30;

    return differenceInMonths >= 1;
  }
}
