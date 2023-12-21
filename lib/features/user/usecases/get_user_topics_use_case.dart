import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserTopicsUseCase {
  const GetUserTopicsUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<Result<List<TopicEntity>>> call() async {
    final userTopicIds = await _userRepository.getUserTopicIds();

    return userTopicIds.fold(
      onSuccess: (topicIds) async {
        final topics = getTopicsUseCase();

        return topics.fold(
          onSuccess: (value) {
            return Result.success(
              [
                ...value.where(
                  (element) => topicIds.contains(element.id),
                ),
              ],
            );
          },
          onFailure: (e) {
            throw e;
          },
        );
      },
      onFailure: (e) {
        throw e;
      },
    );
  }
}
