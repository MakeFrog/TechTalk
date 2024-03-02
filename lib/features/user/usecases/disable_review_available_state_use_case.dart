import 'dart:async';

import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

class DisableReviewAvailableStateUseCase
    extends BaseNoParamUseCase<Result<void>> {
  DisableReviewAvailableStateUseCase(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<void>> call() async =>
      _repository.disableReviewAvailableState();
}
