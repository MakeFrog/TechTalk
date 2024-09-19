import 'dart:async';
import 'dart:ui';

import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/localization/localization_enum.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/data_source/local/system_local_data_source.dart';
import 'package:techtalk/features/system/system.dart';

class SystemRepositoryImpl implements SystemRepository {
  SystemRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final SystemRemoteDataSource _remoteDataSource;
  final SystemLocalDataSource _localDataSource;

  @override
  Future<Result<VersionEntity>> getVersionInfo() async {
    try {
      final response = await _remoteDataSource.getVersionInfo();

      final result = response.toEntity();
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(const VersionInfoFetchedFailedException());
    }
  }

  @override
  Future<Result<Locale?>> getStoredLocale() async {
    try {
      final code = await _localDataSource.loadLocaleLanguageCode();

      if (code == null) {
        final currentLocaleCode = AppLocale.currentLocale.languageCode;
        unawaited(_localDataSource.storeLocaleCode(currentLocaleCode));

        return Result.success(null);
      }

      return Result.success(
        Localization.getMatchedLocalization(code).locale,
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> storeLocale(Locale currentLocale) async {
    try {
      await _localDataSource.storeLocaleCode(currentLocale.languageCode);

      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
