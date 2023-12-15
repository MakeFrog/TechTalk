import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/wrong_answer/selected_wrong_answer_topic_provider.dart';

abstract interface class _WrongAnswerNoteEvent {
  void onTapTopicChip(WidgetRef ref, Topic topic);

  void onTapQuestion(int page);
}

mixin class WrongAnswerNoteEvent implements _WrongAnswerNoteEvent {
  @override
  void onTapTopicChip(WidgetRef ref, Topic topic) {
    ref.read(selectedWrongAnswerTopicProvider.notifier).update(topic);
  }

  @override
  void onTapQuestion(int page) {
    WrongAnswerRoute($extra: page).push(rootNavigatorKey.currentContext!);
  }
}