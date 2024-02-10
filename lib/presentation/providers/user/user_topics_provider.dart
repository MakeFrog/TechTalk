import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'user_topics_provider.g.dart';

@Riverpod(keepAlive: true)
class UserTopics extends _$UserTopics {
  @override
  List<TopicEntity> build() {
    final userData = ref.watch(userInfoProvider).requireValue;
    if (userData == null) throw Exception('유저 데이터가 존재하지 않음');

    final topics = getTopicsUseCase.call();

    final userTopicIds = userData.skills;
    final topicIds = [...topics.map((e) => e.id)];

    final userTopics = <TopicEntity>[];
    for (final userTopicId in userTopicIds) {
      if (topicIds.contains(userTopicId)) {
        final topic = topics.firstWhere(
          (element) => element.id == userTopicId,
        );

        userTopics.add(topic);
      }
    }

    return userTopics;
  }
}
