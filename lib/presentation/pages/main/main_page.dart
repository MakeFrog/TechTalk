import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/main/main_event.dart';
import 'package:techtalk/presentation/pages/main/screens/home/home_screen.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 회원가입을 완료하지 않고 메인으로 접속 시 회원가입 페이지로 이동하기 위한 listener
    ref.listen(appUserDataProvider, (_, next) {
      if (next.valueOrNull != null) {
        if (!next.requireValue!.isCompleteSignUp) {
          const SignUpRoute().go(context);
        }
      }
    });

    return const Scaffold(
      body: _Body(),
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({super.key});

  static const _screens = <Widget>[
    HomeScreen(
      key: ValueKey(0),
    ),
    HomeScreen(
      key: ValueKey(1),
    ),
    HomeScreen(
      key: ValueKey(2),
    ),
    HomeScreen(
      key: ValueKey(3),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    ref.listen(mainBottomNavigationProvider, (_, next) {
      pageController.jumpToPage(next);
    });

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: _screens,
    );
  }
}

class _BottomNavigationBar extends ConsumerWidget with MainEvent {
  const _BottomNavigationBar({super.key});

  static const _items = [
    ('홈', Assets.iconsHome),
    ('학습', Assets.iconsStudy),
    ('오답노트', Assets.iconsNote),
    ('내 정보', Assets.iconsUser),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainBottomNavigationProvider);

    return BottomNavigationBar(
      currentIndex: currentIndex,
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
        ..._items.mapIndexed(
          (index, e) => BottomNavigationBarItem(
            label: e.$1,
            icon: SvgPicture.asset(
              e.$2,
              colorFilter: ColorFilter.mode(
                currentIndex == index ? AppColor.of.gray5 : AppColor.of.gray2,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
