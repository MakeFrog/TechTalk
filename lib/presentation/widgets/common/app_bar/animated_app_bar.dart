import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

///
/// 스크롤 포지션에 따라
/// 앱바 제목의 Opacity가 Animated되는 로직이 적용되어 있는 모듈
///
///

class AnimatedAppBar extends HookWidget implements PreferredSizeWidget {
  const AnimatedAppBar({
    super.key,
    required this.title,
    required this.scrollController,
    required this.opacityPosition,
    bool? showBackBtn,
    this.onBackBtnTapped,
    this.actions,
  }) : showBackBtn = showBackBtn ?? true;

  final String title;
  final bool showBackBtn;
  final VoidCallback? onBackBtnTapped;
  final ScrollController scrollController;
  final double opacityPosition; // Opacity 변환 지점
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final showTitle = useState(false);

    scrollController.addListener(() {
      final scrollPosition = scrollController.offset;

      if (opacityPosition < scrollPosition && !showTitle.value) {
        showTitle.value = true;
        return;
      }

      if (opacityPosition >= scrollPosition && showTitle.value) {
        showTitle.value = false;
        return;
      }
    });

    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColor.of.white,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: 56,
      actions: actions,
      title: AnimatedOpacity(
        opacity: showTitle.value ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: Text(
          title,
          style: AppTextStyle.headline2,
        ),
      ),
      leading: showBackBtn
          ? AppBackButton(
              onBackBtnTapped: onBackBtnTapped ?? context.pop,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
