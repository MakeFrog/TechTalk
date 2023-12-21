import 'dart:async';

import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserTopicsUseCase
    extends BaseNoParamUseCase<Result<List<TopicEntity>>> {
  GetUserTopicsUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  @override
  Future<Result<List<TopicEntity>>> call() async {
    try {
      final userTopicIds = await _userRepository.getUserData().then(
            (value) => value.getOrThrow().topicIds,
          );
      final topics = getTopicsUseCase().getOrThrow();

      return Result.success(
        [
          ...topics.where(
            (element) => userTopicIds.contains(element.id),
          ),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
