import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/topic/topics_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'user_topics_provider.g.dart';

@Riverpod(keepAlive: true)
class UserTopics extends _$UserTopics {
  @override
  List<Topic> build() {
    final topics = ref.watch(topicsProvider).requireValue;
    final userData = ref.watch(userDataProvider).requireValue;

    if (userData == null) throw Exception('유저 데이터가 존재하지 않음');

    return [
      ...topics.where(
        (element) => userData.topicIds.contains(element.id),
      ),
    ];
  }
}
