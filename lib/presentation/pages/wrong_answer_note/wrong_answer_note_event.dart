import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_wrong_answer_topic_provider.dart';

mixin class WrongAnswerNoteEvent {
  void onTapTopicChip(WidgetRef ref, TopicEntity topic) {
    ref.read(selectedWrongAnswerTopicProvider.notifier).update(topic);
  }

  void onTapQuestion(int page) {
    WrongAnswerRoute(page).push(rootNavigatorKey.currentContext!);
  }
}
