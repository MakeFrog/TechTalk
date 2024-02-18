import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'sorted_topics_provider.g.dart';

///
/// 제공되는 전체 면접 주제(Topic) 리스트에서
/// 2가지 기준으로 정렬 및 필터링된 리스트
/// - 유저의 관심 스킬과 관련된 면접 주제를 리스트 맨 앞으로 위치
/// - 현재 유효하지 않은 면접 주제는 리스트에서 제외
///

@riverpod
class SortedTopics extends _$SortedTopics {
  @override
  List<TopicEntity> build() {
    final availableTopics = StoredTopics.list.where((e) => e.isAvailable);
    final storedTopicsByUser = ref
        .read(userInfoProvider)
        .requireValue!
        .skills
        .map(
          (e) => StoredTopics.getBySkillId(e.id),
        )
        .toList();

    storedTopicsByUser.removeWhere((e) => e == null);

    final storedList = availableTopics
        .where(storedTopicsByUser.contains)
        .followedBy(
          availableTopics.where(
            (e) => !storedTopicsByUser.contains(e),
          ),
        )
        .toList();

    return storedList;
  }
}
