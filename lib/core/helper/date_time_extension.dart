import 'package:intl/intl.dart';

extension KoreaDateTimeExt on DateTime {
  /// 년도.월.일 형식의 String으로 반환한다.
  ///
  /// 예를 들어, '2023년 8월 10일'의 경우 '23.08.10'으로 반환한다.
  String get formatToyyMMdd {
    return DateFormat('yy.MM.dd').format(this);
  }
}
