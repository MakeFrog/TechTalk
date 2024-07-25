import 'package:hive_flutter/hive_flutter.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/data_source/local/boxes/system_box.dart';
import 'package:techtalk/features/system/data_source/local/system_local_data_source.dart';

final class SystemLocalDataSourceImpl implements SystemLocalDataSource {
  SystemLocalDataSourceImpl(this.box);

  final Box<SystemBox> box;

  SystemBox? get systemInfo => box.values.firstOrNull;

  @override
  Future<String?> loadLocaleCode() async {
    final systemBox = box.get(AppLocal.systemBoxName);
    if (systemBox == null) return null;

    return systemBox.languageCode;
  }

  @override
  Future<void> storeLocaleCode(String code) async {
    await box.put(AppLocal.systemBoxName, SystemBox(languageCode: code));
  }
}
