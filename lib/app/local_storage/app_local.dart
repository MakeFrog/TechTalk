import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/features/user/data_source/local/boxes/user_box.dart';

abstract class AppLocal {
  AppLocal._();

  static String userBoxName = 'user';
  static late Box<UserBox> userBox;

  static void initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);

    Hive.registerAdapter(UserBoxAdapter());
    userBox = await Hive.openBox<UserBox>(userBoxName);
  }
}
