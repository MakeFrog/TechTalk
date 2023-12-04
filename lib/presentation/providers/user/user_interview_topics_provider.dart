import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'user_interview_topics_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInterviewTopics extends _$UserInterviewTopics {
  @override
  FutureOr<List<InterviewTopic>> build() async {
    final userData = await ref.watch(userDataProvider.future);
    if (userData == null) throw Exception('유저 데이터가 존재하지 않음');

    final topicIds = userData.skills;
    final topics = await getInterviewTopicListUseCase();

    final userTopics = topics
        .where(
          (element) => topicIds.contains(element.id),
        )
        .toList();

    return userTopics;
  }
}
