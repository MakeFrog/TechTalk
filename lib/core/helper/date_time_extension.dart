import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  ///
  /// 년도.월.일 형식의 String으로 반환
  /// 예를 들어, '2023년 8월 10일'의 경우 '23.08.10'으로 반환한다.
  ///
  String get formatToyyMMdd {
    return DateFormat('yy.MM.dd').format(this);
  }

  // ///
  // /// 주어진 날짜가 비교된 날짜보다 최신 날짜인지
  // /// 확인하는 메소드. 최신 여부에 따라 boolean 값을 리턴
  // ///
  // bool isNewerDateThan(DateTime compareDate) {
  //   return compareTo(compareDate) == 1;
  // }
}
