import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/chat/widgets/interview_tab_view.dart';
import 'package:techtalk/presentation/pages/chat/widgets/qna_tab_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

part 'widgets/chat_page_app_bar.dart';
part 'widgets/chat_page_scaffold.dart';

class ChatPage extends BaseRefHookPage {
  const ChatPage({Key? key}) : super(key: key);

  @override
  void onInit(WidgetRef? ref) {
    print("chat page initialized");
  }

  @override
  void onDispose(WidgetRef? ref) {
    print("chat page disposed");
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);

    return _Scaffold(
      chatTabView: const InterviewTabView(),
      summaryTabView: const QnATabView(),
      tabController: tabController,
    );
  }

  @override
  bool get preventSwipeBack => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => const _AppBar();
}
