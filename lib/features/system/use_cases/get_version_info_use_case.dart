import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/system.dart';

class GetVersionInfoUseCase extends BaseNoParamUseCase<Result<VersionEntity>> {
  GetVersionInfoUseCase(this._repository);

  final SystemRepository _repository;

  @override
  Future<Result<VersionEntity>> call() => _repository.getVersionInfo();
}
