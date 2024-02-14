import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class FoldableAppBar extends HookWidget implements PreferredSizeWidget {
  const FoldableAppBar({
    super.key,
    double? height,
    required this.title,
    required this.scrollController,
    required this.animatedPosition,
  }) : height = height ?? 56;

  final String title;
  final double height;
  final ScrollController scrollController;
  final double animatedPosition;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: HookBuilder(
        builder: (context) {
          final isFold = useState(false);

          scrollController.addListener(() {
            final scrollPosition = scrollController.offset;

            if (animatedPosition < scrollPosition && !isFold.value) {
              isFold.value = true;
              return;
            }

            if (animatedPosition >= scrollPosition && isFold.value) {
              isFold.value = false;
              return;
            }
          });
          return AnimatedContainer(
            height: isFold.value ? 0 : height,
            duration: const Duration(milliseconds: 200),
            child: AnimatedOpacity(
              opacity: isFold.value ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: AppTextStyle.headline2,
                    textAlign: TextAlign.start,
                  ),
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
