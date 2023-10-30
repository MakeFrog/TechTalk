import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_list_provider.dart';

class QuestionAndAnswerTabView extends ConsumerWidget with ChatEvent {
  const QuestionAndAnswerTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListAsync = ref.watch(chatListProvider);

    return Center(
      child: Text('${chatListAsync.value?.length ?? '없음'}'),
    );
  }
}
