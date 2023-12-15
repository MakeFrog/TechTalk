import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserInterviewTopicsUseCase {
  const GetUserInterviewTopicsUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<List<Topic>> call() async {
    final topics = await _userRepository.getUserTopicIds();

    return topics.fold(
      onSuccess: (value) {
        return [
          ...Topic.values.where((element) => value.contains(element.id)),
        ];
      },
      onFailure: (e) {
        throw e;
      },
    );
  }
}
