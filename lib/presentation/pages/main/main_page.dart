import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/pages/home/home_page.dart';
import 'package:techtalk/presentation/pages/main/main_event.dart';
import 'package:techtalk/presentation/pages/my_info/my_page/my_page.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/study_topic_selection_page.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_page.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class MainPage extends BasePage with MainEvent {
  const MainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    const _pages = [
      HomePage(
        key: ValueKey(MainNavigationTab.home),
      ),
      StudyTopicSelectionPage(
        key: ValueKey(MainNavigationTab.study),
      ),
      WrongAnswerNotePage(
        key: ValueKey(MainNavigationTab.note),
      ),
      MyPage(
        key: ValueKey(MainNavigationTab.myInfo),
      ),
    ];

    final mainTabController = usePageController();

    ref.listen(mainBottomNavigationProvider, (_, next) {
      HapticFeedback.lightImpact();
      mainTabController.jumpToPage(next.index);
    });

    final currentTab = ref.watch(mainBottomNavigationProvider).index;

    return PageView(
      controller: mainTabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ..._pages.mapIndexed(
          (index, e) => e
              .animate(
                target: currentTab == index ? 1 : 0,
              )
              .fade(duration: 200.ms),
        ),
      ],
    );
  }

  @override
  void onInit(WidgetRef ref) {
    super.onInit(ref);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      activateNetworkConnectivityDetector(ref);
      alertRateAppDialogIfNeeded(ref);
    });
  }

  @override
  Color? get unSafeAreaColor => AppColor.of.background1;

  @override
  bool get setTopSafeArea => false;

  @override
  bool get setBottomSafeArea => false;

  @override
  bool get canPop => false;

  @override
  Widget buildBottomNavigationBar(BuildContext context) =>
      const _BottomNavigationBar();
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
