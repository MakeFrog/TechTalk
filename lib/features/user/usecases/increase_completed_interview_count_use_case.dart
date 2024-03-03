import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class IncreaseCompletedInterviewCountUseCase
    extends BaseNoParamUseCase<Result<int>> {
  IncreaseCompletedInterviewCountUseCase(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<int>> call() async =>
      _repository.increaseCompletedInterviewCount();
}
