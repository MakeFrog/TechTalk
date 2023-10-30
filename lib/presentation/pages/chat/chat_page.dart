import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/chat/widgets/interview_tab_view.dart';
import 'package:techtalk/presentation/pages/chat/widgets/question_and_answer_tab_view.dart';
import 'package:techtalk/presentation/widgets/common/state/keep_alive_view.dart';

part 'widgets/chat_page_app_bar.dart';
part 'widgets/chat_page_scaffold.dart';

class ChatPage extends HookConsumerWidget with ChatEvent {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);

    return _Scaffold(
      appBar: const _AppBar(),
      chatTabView: const InterviewTabView(),
      summaryTabView: const QuestionAndAnswerTabView(),
      tabController: tabController,
    );
  }
}
