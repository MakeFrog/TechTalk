import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'user_topics_provider.g.dart';

@Riverpod(keepAlive: true)
class UserTopics extends _$UserTopics {
  @override
  List<TopicEntity> build() {
    final userInfo = ref.watch(userInfoProvider).requireValue;
    if (userInfo == null) return [];
    final List<TopicEntity> skillRelatedTopics = [];

    for (var skill in userInfo.skills) {
      final relatedTopic = StoredTopics.getByIdOrNull(skill.id);
      if (relatedTopic != null) {
        skillRelatedTopics.add(relatedTopic);
      }
    }

    final combinedTopics =
        skillRelatedTopics.toCombinedSetList(userInfo.recordedTopics);

    return combinedTopics;
  }
}
