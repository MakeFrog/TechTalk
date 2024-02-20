import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_box.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_list_box.dart';
import 'package:techtalk/features/user/data_source/local/boxes/user_box.dart';

abstract class AppLocal {
  AppLocal._();

  static String userBoxName = 'user';
  static String qnasBoxName = 'qnas';

  static late Box<UserBox> userBox;
  static late Box<QnaListBox> qnasBox;

  static void initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);

    Hive
      ..registerAdapter(UserBoxAdapter())
      ..registerAdapter(QnaBoxAdapter())
      ..registerAdapter(QnaListBoxAdapter());

    userBox = await Hive.openBox<UserBox>(userBoxName);
    qnasBox = await Hive.openBox<QnaListBox>(qnasBoxName);
  }

  static void clearCache() {
    userBox.clear();
    qnasBox.clear();
  }
}
