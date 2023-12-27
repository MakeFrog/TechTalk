import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/system/entities/version_entity.dart';

abstract interface class SystemRepository {
  Future<Result<VersionEntity>> getVersionInfo();
}
