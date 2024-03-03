import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

class DisableReviewAvailableStateUseCase
    extends BaseNoParamUseCase<Result<void>> {
  DisableReviewAvailableStateUseCase(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<void>> call() async =>
      _repository.disableReviewAvailableState();
}
