import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'user_interview_topics_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInterviewTopics extends _$UserInterviewTopics {
  @override
  FutureOr<List<InterviewTopic>> build({
    bool onlyAvailable = false,
  }) async {
    final userData = await ref.watch(userDataProvider.future);
    if (userData == null) throw Exception('유저 데이터가 존재하지 않음');

    return getUserInterviewTopicsUseCase();
  }
}

@riverpod
FutureOr<List<InterviewTopic>> availableUserInterviewTopics(
  AvailableUserInterviewTopicsRef ref,
) async {
  final topics =
      await ref.watch(userInterviewTopicsProvider(onlyAvailable: true).future);

  return [
    ...topics.where((element) => element.isAvailable),
  ];
}
