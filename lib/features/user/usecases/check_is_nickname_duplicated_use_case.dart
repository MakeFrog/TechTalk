import 'dart:async';

import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class CheckIsNicknameDuplicatedUseCase
    extends BaseUseCase<String, Result<bool>> {
  CheckIsNicknameDuplicatedUseCase(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<bool>> call(String request) {
    return _repository.isNicknameDuplicated(request);
  }
}
