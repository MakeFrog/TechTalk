import 'package:techtalk/core/modules/base_use_case/base_no_param_use_case.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/system/repositories/entities/version_entity.dart';
import 'package:techtalk/features/system/repositories/system_repository.dart';

class GetVersionInfoUseCase extends BaseNoParamUseCase<Result<VersionEntity>> {
  GetVersionInfoUseCase(this._repository);

  final SystemRepository _repository;

  @override
  Future<Result<VersionEntity>> call() => _repository.getVersionInfo();
}
