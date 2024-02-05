import 'dart:async';

import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class StoreUserLocalInfoUseCase
    extends BaseUseCase<UserEntity, Result<void>> {
  StoreUserLocalInfoUseCase(this._repository);
  final UserRepository _repository;

  @override
  FutureOr<Result<void>> call(UserEntity request) {
    return _repository.storeUserLocalInfo(request);
  }
}
