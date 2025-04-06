import 'package:easy_localization/easy_localization.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/helper/string_extension.dart';

abstract class AppValidator {
  ///
  /// 유튜브 영상 url인지 여부
  ///
  static bool isYoutubeVideoUrl(String? url) {
    if (url == null) return false;

    final regex = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com\/(watch\?v=|embed\/|v\/|shorts\/)|youtu\.be\/)[a-zA-Z0-9_-]+([&?].*)?$',
    );

    return regex.hasMatch(url);
  }

  ///
  /// URL 여부
  ///
  static bool isValidUrl(String? url) {
    if (url == null) return false;
    final regex = RegExp(r'^(https?:\/\/)?' // http:// 또는 https:// (옵션)
        r'([\w-]+\.)+[\w-]+' // 도메인 이름
        r'(:\d+)?' // 포트 번호 (옵션)
        r'(\/[^\s]*)?$' // 경로 및 쿼리 파라미터 (옵션)
        );
    return regex.hasMatch(url);
  }

  ///
  /// 유효한 '스킬' [TechSetType.skill] 검색어를 입력했는지여부
  ///
  static String? skillInputValidation(
      {required String? input, required bool isResultEmpty}) {
    final currentContext = rootNavigatorKey.currentContext;
    if (rootNavigatorKey.currentContext == null) return '404';
    if (input == null) {
      return currentContext!.tr(LocaleKeys.jobSelection_needSearchKeyword);
    } else if (input.containsKorean) {
      return currentContext!.tr(LocaleKeys.jobSelection_needToSearchInEnglish);
    } else if (isResultEmpty && input.isNotEmpty && !input.containsKorean) {
      return currentContext!.tr(LocaleKeys.jobSelection_noResultFound);
    } else {
      return null;
    }
  }
}
