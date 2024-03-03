import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

final class CheckNicknameDuplication extends BaseUseCase<String, Result<bool>> {
  CheckNicknameDuplication(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<bool>> call(String request) {
    return _repository.isNicknameDuplicated(request);
  }
}
