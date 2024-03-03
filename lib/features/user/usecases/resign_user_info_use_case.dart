import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

final class ResignUserInfoUseCase
    extends BaseUseCase<UserEntity, Result<void>> {
  ResignUserInfoUseCase(this._userRepository, this._topicRepository);

  final UserRepository _userRepository;
  final TopicRepository _topicRepository;

  @override
  FutureOr<Result<void>> call(UserEntity request) async {
    final topicRes = await _topicRepository.deleteUserWrongAnswers();
    topicRes.getOrThrow();

    return _userRepository.deleteUser(request);
  }
}
