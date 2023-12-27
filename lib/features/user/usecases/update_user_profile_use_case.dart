import 'dart:io';

import 'package:async/async.dart';
import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

class UpdateUserProfileUseCase
    extends BaseUseCase<(UserDataEntity user, File imageFile), Result<void>> {
  UpdateUserProfileUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<Result<void>> call((UserDataEntity, File) request) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
