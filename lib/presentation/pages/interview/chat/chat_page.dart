import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/interview_tab_view.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/qna_tab_view.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'widgets/chat_page_scaffold.dart';

part 'widgets/chat_page_app_bar.p.dart';

class ChatPage extends BasePage with ChatEvent, ChatState {
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
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  bool get canPop => false;

  @override
  bool get wrapWithSafeArea => false;

  @override
  void onWillPop(WidgetRef ref) {
    onAppbarBackBtnTapped(ref);
  }

  static const double tabBarHeight = 48;

  static double tabViewHeight = AppSize.screenHeight -
      AppSize.statusBarHeight -
      BackButtonAppBar.appbarHeight -
      ChatPage.tabBarHeight;

  @override
  void onInit(WidgetRef ref) {
    super.onInit(ref);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        updateFirstEnteredStateToTrue();
      },
    );

    FirebaseAnalytics.instance.logEvent(
      name: 'Interview Created',
      parameters: {
        'user_id': ref.read(userInfoProvider).requireValue?.uid,
        'user_name': ref.read(userInfoProvider).requireValue?.nickname,
        'interview_type': ref.read(selectedChatRoomProvider).type.name,
        'topics': ref
            .read(selectedChatRoomProvider)
            .topics
            .map((e) => e.text)
            .join(', ')
      },
    );
  }
}
