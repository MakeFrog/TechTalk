import 'package:flutter/material.dart';

enum Localization {
  en(locale: Locale('en', 'US')),
  kr(locale: Locale('ko', 'KR'));
    
  final Locale locale;

  const Localization({required this.locale});

  ///
  /// language 코드오 매칭된 locale을 반환해주는 코드입니다.
  ///
  static Localization getMatchedLocalization(String languageCode) {
    if (languageCode == Localization.kr.locale.languageCode) {
      return Localization.kr;
    } else {
      return Localization.en;
    }
  }
}
