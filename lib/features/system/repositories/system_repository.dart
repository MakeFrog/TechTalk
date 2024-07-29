import 'dart:ui';

import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/system/system.dart';

abstract interface class SystemRepository {
  ///
  /// 앱 버전 정보 호출
  ///
  Future<Result<VersionEntity>> getVersionInfo();

  ///
  /// 마지막으로 설저된 local 정보 호출
  ///
  Future<Result<Locale?>> getStoredLocale();

  ///
  /// [Locale] language코드를 로컬 스토리지에 저장
  ///
  Future<Result<void>> storeLocale(Locale currentLocale);
}
