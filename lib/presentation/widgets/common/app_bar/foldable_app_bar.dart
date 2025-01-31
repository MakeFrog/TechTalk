import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';

///
/// 스크롤 포지션을 offset을 기준점으로
/// 높이가 축소되고 opacity animation이 적용되어 있는 AppBar
///
class FoldableAppBar extends HookWidget implements PreferredSizeWidget {
  const FoldableAppBar({
    super.key,
    double? height,
    required this.scrollController,
    required this.animatedPosition,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackBtnTapped,
  }) : height = height ?? 56;

  final String? title;
  final double height;
  final ScrollController scrollController;
  final double animatedPosition;
  final bool showBackButton;
  final VoidCallback? onBackBtnTapped;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: HookBuilder(
        builder: (context) {
          final isFold = useState(false);

          scrollController.addListener(() {
            try {
              final scrollPosition = scrollController.offset;

              if (animatedPosition < scrollPosition && !isFold.value) {
                isFold.value = true;
                return;
              }

              if (animatedPosition >= scrollPosition && isFold.value) {
                isFold.value = false;
                return;
              }
            } catch (e) {
              print('화면이 roatate 경우 \'isFold\' state이 해제될 수 있습니다 $e');
            }
          });

          return AnimatedContainer(
            height: isFold.value ? 0 : height,
            duration: const Duration(milliseconds: 200),
            child: AnimatedOpacity(
              opacity: isFold.value ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: double.infinity,
                    ),
                    if (showBackButton)
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: onBackBtnTapped ?? context.pop,
                        child: Container(
                          height: height,
                          width: 60,
                          padding: const EdgeInsets.only(left: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              Assets.iconsIconAppBarLeft,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    if (title != null)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: showBackButton ? 48 : 16,
                        child: SizedBox(
                          height: 56,
                          child: Center(
                            child: Text(
                              title!,
                              style: AppTextStyle.headline2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Row(
                        children: [
                          ...?actions,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
