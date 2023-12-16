import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/stored_topics.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'selected_review_note_topic_provider.g.dart';

@riverpod
class SelectedReviewNoteTopic extends _$SelectedReviewNoteTopic {
  @override
  FutureOr<TopicEntity> build() async {
    final topics = await ref.watch(userDataProvider.future);

    return topics!.skillIdList.map(StoredTopics.getById).first;
  }

  set topic(TopicEntity value) => state = AsyncData(value);
}
