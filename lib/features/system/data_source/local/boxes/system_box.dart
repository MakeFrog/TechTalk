import 'package:hive_flutter/hive_flutter.dart';

part 'system_box.g.dart';

///
/// 앱의 전박적인 시스템 설정(locale, version, 마지막 접속일 등등)과 관련된
/// 로컬 스토리지 데이터
/// 추가 항목이 필요할 시 아래 멤버 변수에 추가하여 관리
///
@HiveType(typeId: 3)
class SystemBox extends HiveObject {
  /// 유저의 locale
  @HiveField(0)
  final String languageCode;

  SystemBox({required this.languageCode});
}
