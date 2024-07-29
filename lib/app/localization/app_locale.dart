import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';

import 'localization_enum.dart';

///
/// 현재 앱에 설정된 [Locale]에 대한 정보를 제공하는 모듈
/// 레이어 영향을 받지 않고 어디서든 사용될 수 있는 내부적인 규칙을 가짐
/// DataSource, Repository, Presentation 등등 어디서든 유연하게 사용될 수 있음
///
abstract final class AppLocale {
  static Locale get currentLocale {
    /// 현재 context로부터 locale을 가져올 수 없다면 Local Storage에 저장된 값을 가져옴.
    /// [NOTE]
    /// 이런 경우는 거의 발생하지 않겠지만.. 혹시 모를 안전장치
    if (rootNavigatorKey.currentContext == null) {
      final languageCode =
          AppLocal.systemBox.get(AppLocal.systemBoxName)?.languageCode ?? Localization.en.locale.languageCode;

      return Localization.getMatchedLocalization(languageCode).locale;
    }

    /// 혹시나 db에 잘못된 languageCode 접근 방지위해 enum을 통해 넘겨준다.
    return Localization.getMatchedLocalization(rootNavigatorKey.currentContext!.locale.languageCode).locale;
  }

  ///
  /// locale 정보 반환 메소드
  ///
  static String getLocaleName() {
    return Platform.localeName;
  }

  static bool get isKo => currentLocale.languageCode == 'ko';

  static bool get isEn => currentLocale.languageCode == 'en';
}
