import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/system/data_source/remote/system_remote_data_source.dart';
import 'package:techtalk/features/system/repositories/entities/version_entity.dart';
import 'package:techtalk/features/system/repositories/system_repository.dart';

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
