import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

final class StoreUserLocalInfoUseCase
    extends BaseUseCase<UserEntity, Result<void>> {
  StoreUserLocalInfoUseCase(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<void>> call(UserEntity request) {
    return _repository.storeUserLocalInfo(request);
  }
}
