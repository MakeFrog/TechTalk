import 'package:flutter/material.dart';

enum Localization {
  en(locale: Locale('en', 'US')),
  kr(locale: Locale('ko', 'KR'));

  final Locale locale;

  const Localization({required this.locale});
}
