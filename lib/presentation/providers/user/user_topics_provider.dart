import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'user_topics_provider.g.dart';

@Riverpod(keepAlive: true)
class UserTopics extends _$UserTopics {
  @override
  List<TopicEntity> build() {
    final userData = ref.watch(userDataProvider).requireValue;
    if (userData == null) throw Exception('유저 데이터가 존재하지 않음');

    final topics = getTopicsUseCase().getOrThrow();

    final userTopicIds = userData.topicIds;
    final topicIds = [...topics.map((e) => e.id)];

    for (final userTopicId in userTopicIds) {
      if (topicIds.contains(userTopicId)) {
        final topic = topics.firstWhere(
          (element) => element.id == userTopicId,
        );

        topics.remove(topic);
        topics.insert(0, topic);
      }
    }

    return topics;
  }
}
