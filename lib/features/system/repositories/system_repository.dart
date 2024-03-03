import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/system/repositories/entities/version_entity.dart';

abstract interface class SystemRepository {
  ///
  /// 앱 버전 정보 호출
  ///
  Future<Result<VersionEntity>> getVersionInfo();
}
