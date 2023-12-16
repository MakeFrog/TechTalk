import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserInterviewTopicsUseCase {
  const GetUserInterviewTopicsUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<List<TopicEntity>> call() async {
    final topics = await _userRepository.getUserTopicList();

    return topics.fold(
      onSuccess: (value) {
        return value;
      },
      onFailure: (e) {
        throw e;
      },
    );
  }
}
