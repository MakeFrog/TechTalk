import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/system.dart';

class SystemRepositoryImpl implements SystemRepository {
  SystemRepositoryImpl(this._remoteDataSource);

  final SystemRemoteDataSource _remoteDataSource;

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
}
