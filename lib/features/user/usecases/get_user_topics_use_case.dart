import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserTopicsUseCase {
  const GetUserTopicsUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<List<Topic>> call() async {
    final userTopicIds = await _userRepository.getUserTopicIds();

    return userTopicIds.fold(
      onSuccess: (topicIds) async {
        final topics = await getTopicsUseCase();

        return topics.fold(
          onSuccess: (value) {
            return [
              ...value.where(
                (element) => topicIds.contains(element.id),
              ),
            ];
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
