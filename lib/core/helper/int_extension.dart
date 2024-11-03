import 'package:techtalk/app/localization/localization_enum.dart';

extension IntExtensions on int {
  ///
  /// 숫자의 포맷팅을 짧게 해주는 함수
  /// 조회수와 같은 용도에 적합
  ///
  String formatViewCount(Localization locale) {
    if (locale == Localization.kr) {
      return _formatKorean(this, '회');
    } else {
      return _formatEnglish(this, 'views');
    }
  }

  ///
  /// 숫자의 포맷팅을 짧게 해주는 함수
  /// 다양한 용도에 사용 가능
  ///
  String formatCount(Localization locale, {String suffix = ''}) {
    if (locale == Localization.kr) {
      return _formatKorean(this, suffix);
    } else {
      return _formatEnglish(this, suffix);
    }
  }

  String _formatKorean(int count, String suffixText) {
    if (count < 100) {
      return '$count$suffixText';
    } else if (count < 1000) {
      double result = count / 100;
      return '${_trimDecimal(result)}백$suffixText';
    } else if (count < 10000) {
      double result = count / 1000;
      return '${_trimDecimal(result)}천$suffixText';
    } else if (count < 100000000) {
      // 1억 미만
      double result = count / 10000;
      return '${_trimDecimal(result)}만$suffixText';
    } else {
      double result = count / 100000000;
      return '${_trimDecimal(result)}억$suffixText';
    }
  }

  String _formatEnglish(int count, String suffixText) {
    if (count < 1000) {
      return '$count$suffixText';
    } else if (count < 1000000) {
      double result = count / 1000;
      return '${_trimDecimal(result)}K$suffixText';
    } else if (count < 1000000000) {
      double result = count / 1000000;
      return '${_trimDecimal(result)}M$suffixText';
    } else {
      double result = count / 1000000000;
      return '${_trimDecimal(result)}B$suffixText';
    }
  }

  String _trimDecimal(double number) {
    // 소수점 첫째 자리까지 표시, 필요 없으면 정수로 표시
    return number == number.roundToDouble() ? number.toInt().toString() : number.toStringAsFixed(1);
  }
}
