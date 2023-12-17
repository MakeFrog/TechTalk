import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/home/home_page.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_page.dart';
import 'package:techtalk/presentation/pages/main/main_event.dart';
import 'package:techtalk/presentation/pages/study/topic_select/study_topic_select_page.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_page.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class MainPage extends BasePage {
  const MainPage({super.key});

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Body();
  }

  @override
  Widget buildBottomNavigationBar(BuildContext context) =>
      const _BottomNavigationBar();
}

class _Body extends HookConsumerWidget {
  const _Body({super.key});

  static final _screens = [
    const HomePage(
      key: ValueKey(MainNavigationTab.home),
    ),
    const StudyTopicSelectPage(
      key: ValueKey(MainNavigationTab.study),
    ),
    const WrongAnswerNotePage(
      key: ValueKey(MainNavigationTab.note),
    ),
    ChatListPage(
      key: const ValueKey(MainNavigationTab.myInfo),
      topicId: 'swift',
    ),
    // TestPage(
    //   key: ValueKey(MainNavigationTab.myInfo),
    // ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTabController = usePageController();
    ref.listen(mainBottomNavigationProvider, (_, next) {
      mainTabController.jumpToPage(next.index);
    });
    final currentTab = ref.watch(mainBottomNavigationProvider).index;

    return PageView(
      controller: mainTabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ..._screens.mapIndexed(
          (index, e) => e
              .animate(
                target: currentTab == index ? 1 : 0,
              )
              .fade(duration: 200.ms),
        ),
      ],
    );
  }
}

class _BottomNavigationBar extends ConsumerWidget with MainEvent {
  const _BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(mainBottomNavigationProvider);

    return BottomNavigationBar(
      currentIndex: currentTab.index,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.of.gray5,
      unselectedItemColor: AppColor.of.gray2,
      selectedLabelStyle: AppTextStyle.alert2,
      unselectedLabelStyle: AppTextStyle.alert2,
      onTap: (value) => onTapBottomNavigationItem(
        ref,
        index: value,
      ),
      items: [
        ...MainNavigationTab.values.mapIndexed(
          (index, e) => BottomNavigationBarItem(
            label: e.label,
            icon: SvgPicture.asset(
              e.iconPath,
              colorFilter: ColorFilter.mode(
                currentTab.index == index
                    ? AppColor.of.gray5
                    : AppColor.of.gray2,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
