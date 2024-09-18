import 'package:hive_flutter/hive_flutter.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/localization/localization_enum.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/data_source/local/boxes/system_box.dart';
import 'package:techtalk/features/system/data_source/local/system_local_data_source.dart';

final class SystemLocalDataSourceImpl implements SystemLocalDataSource {
  SystemLocalDataSourceImpl(this.box);

  final Box<SystemBox> box;

  SystemBox? get systemInfo => box.values.firstOrNull;

  @override
  Future<String?> loadLocaleLanguageCode() async {
    final systemBox = box.get(AppLocal.systemBoxName);
    if (systemBox == null) return null;

    return systemBox.languageCode;
  }

  @override
  Future<void> storeLocaleCode(String code) async {
    await box.put(
        AppLocal.systemBoxName,
        SystemBox(
            languageCode: code,
            virtualKeyboardHeight: systemInfo?.virtualKeyboardHeight));
  }

  @override
  Future<double?> loadKeyboardHeight() async {
    final systemBox = box.get(AppLocal.systemBoxName);
    if (systemBox == null) return null;

    return systemBox.virtualKeyboardHeight;
  }

  @override
  Future<void> storeKeyboardHeight(double height) async {
    await box.put(
      AppLocal.systemBoxName,
      SystemBox(
        languageCode: systemInfo?.languageCode ?? Localization.en.name,
        virtualKeyboardHeight: height,
      ),
    );
  }
}
