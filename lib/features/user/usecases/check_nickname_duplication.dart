import 'dart:async';

import 'package:techtalk/core/modules/base_use_case/base_use_case.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class CheckNicknameDuplication extends BaseUseCase<String, Result<bool>> {
  CheckNicknameDuplication(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<bool>> call(String request) {
    return _repository.isNicknameDuplicated(request);
  }
}
