import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/features/system/data_source/local/boxes/system_box.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_box.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_list_box.dart';
import 'package:techtalk/features/user/data_source/local/boxes/user_box.dart';

abstract class AppLocal {
  AppLocal._();

  /// Hive Box key값
  static String userBoxName = 'user';
  static String qnasBoxName = 'qnas';
  static String systemBoxName = 'system';

  //// Hive Box 인스턴스
  static late Box<UserBox> userBox;
  static late Box<QnaListBox> qnasBox;
  static late Box<SystemBox> systemBox;

  /// hive Local Storage 초기화
  static Future<void> initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);

    /// 앱에서 정의된 BoxAdapter 등록
    Hive
      ..registerAdapter(UserBoxAdapter())
      ..registerAdapter(QnaBoxAdapter())
      ..registerAdapter(QnaListBoxAdapter())
      ..registerAdapter(SystemBoxAdapter());

    /// Box 열기
    userBox = await Hive.openBox<UserBox>(userBoxName);
    qnasBox = await Hive.openBox<QnaListBox>(qnasBoxName);
    systemBox = await Hive.openBox<SystemBox>(systemBoxName);
  }

  ///
  /// 앱에 저장된 모든 로컬 데이터 제거
  ///
  static void clearAllLocalStorage() {
    userBox.clear();
    qnasBox.clear();
    systemBox.clear();
  }
}
