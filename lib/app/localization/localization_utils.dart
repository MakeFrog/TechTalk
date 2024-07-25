import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class LocalizationUtils {
  // context가 없는 곳에서 Localization을 적용해야 할 경우 사용
  static String localizeNoContext(BuildContext context, String jsonKey) {
    return jsonKey.tr();
  }
}
