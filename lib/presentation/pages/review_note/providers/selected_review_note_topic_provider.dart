import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

part 'selected_review_note_topic_provider.g.dart';

@riverpod
class SelectedReviewNoteTopic extends _$SelectedReviewNoteTopic {
  @override
  FutureOr<InterviewTopic> build() async {
    final topics = await ref.watch(appUserDataProvider.future);

    return topics!.techSkillIdList.map(InterviewTopic.getTopicById).first;
  }

  set topic(InterviewTopic value) => state = AsyncData(value);
}
