import 'package:intl/intl.dart';

abstract class Formatter {
  Formatter._();

  static String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('a hh:mm', 'ko_KR');
    return dateFormat.format(dateTime);
  }
}
