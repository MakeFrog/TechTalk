import 'package:techtalk/features/system/data/model/version_model.dart';

abstract interface class SystemRemoteDataSource {
  /// 앱 버전 정보 호출
  Future<VersionModel> getVersionInfo();
}
