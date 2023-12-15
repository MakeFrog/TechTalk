import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'selected_review_note_topic_provider.g.dart';

@riverpod
class SelectedReviewNoteTopic extends _$SelectedReviewNoteTopic {
  @override
  FutureOr<Topic> build() async {
    final topics = await ref.watch(userDataProvider.future);

    return topics!.topicIds.map(Topic.getTopicById).first;
  }

  set topic(Topic value) => state = AsyncData(value);
}
