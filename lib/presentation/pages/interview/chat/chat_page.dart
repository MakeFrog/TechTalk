import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/qna_tab_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

part 'widgets/chat_page_scaffold.dart';

class ChatPage extends BasePage with ChatEvent {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);

    return _Scaffold(
      chatTabView: const InterviewTabView(),
      summaryTabView: const QnaTabView(),
      tabController: tabController,
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    final firstTopic = ref.watch(selectedChatRoomProvider).topics.first.text;
    final otherTopicCount =
        ref.watch(selectedChatRoomProvider).topics.length - 1;

    return BackButtonAppBar(
      title: '$firstTopic${otherTopicCount > 0 ? ' 외 $otherTopicCount' : ''}',
      onBackBtnTapped: () {
        onAppbarBackBtnTapped(ref);
      },
    );
  }

  @override
  bool get canPop => false;

  @override
  void onWillPop(WidgetRef ref) {
    onAppbarBackBtnTapped(ref);
  }

  static const double tabBarHeight = 48;

  static double tabViewHeight = AppSize.to.screenHeight -
      AppSize.to.statusBarHeight -
      BackButtonAppBar.appbarHeight -
      ChatPage.tabBarHeight;
}
