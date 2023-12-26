import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/system/data/remote/system_remote_data_source.dart';
import 'package:techtalk/features/system/repositories/entities/version_entity.dart';
import 'package:techtalk/features/system/repositories/system_repository.dart';

class SystemRepositoryImpl implements SystemRepository {
  SystemRepositoryImpl(this._dataSource);

  final SystemRemoteDataSource _dataSource;

  @override
  Future<Result<VersionEntity>> getVersionInfo() async {
    try {
      final response = await _dataSource.getVersionInfo();
      final result = VersionEntity.fromModel(response);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
