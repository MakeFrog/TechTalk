import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

///
/// 면접 주제 리스트 호출.
/// 전체 면접 주제들중에 유저의 테크 주제 리스트를 우선적으로 정렬하여 보여줌
///
final class GetTopicsUseCase extends BaseNoParamUseCase<Result<List<Topic>>> {
  GetTopicsUseCase({
    required TopicRepository topicRepository,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _topicRepository = topicRepository;

  final TopicRepository _topicRepository;
  final UserRepository _userRepository;

  @override
  Future<Result<List<Topic>>> call({
    bool sort = false,
    bool onlyAvailable = false,
  }) async {
    try {
      List<Topic> topics = [..._topicRepository.getTopics().getOrThrow()];

      if (sort) {
        final userTopicIds =
            (await _userRepository.getUserTopicIds()).getOrThrow();
        final topicIds = [...topics.map((e) => e.id)];

        for (final topicId in userTopicIds) {
          if (topicIds.contains(topicId)) {
            final topic = topics.firstWhere(
              (element) => element.id == topicId,
            );

            topics.remove(topic);
            topics.insert(0, topic);
          }
        }
      }

      if (onlyAvailable) {
        topics = [
          ...topics.where((element) => element.isAvailable),
        ];
      }

      return Result.success(topics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
