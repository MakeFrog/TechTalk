import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/presentation/widgets/common/chip/closable_rect_filled_chip.dart';

class SelectedJobGroupListViewDelegate extends SliverPersistentHeaderDelegate {
  SelectedJobGroupListViewDelegate({
    required this.selectedJobGroups,
    required this.onTapItem,
    required this.scrollController,
  });

  final List<JobGroup> selectedJobGroups;
  final void Function(JobGroup) onTapItem;
  final double expandedHeight = 68;
  final ScrollController scrollController;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return HookBuilder(
          builder: (context) {
            final animationController = useAnimationController(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 500),
              initialValue: selectedJobGroups.isNotEmpty ? 1.0 : 0.0,
            );

            useEffect(() {
              if (selectedJobGroups.isNotEmpty) {
                animationController.forward();
              } else {
                animationController.reverse();
              }

              return null;
            }, [selectedJobGroups, animationController]);
            // 애니메이션 컨트롤러

            /// 애니메이션
            final animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              ),
            );
            return AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return Align(
                  heightFactor: animation.value,
                  child: Container(
                    color: AppColor.of.white,
                    height: selectedJobGroups.isNotEmpty ? expandedHeight : 0,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (BuildContext context, Widget? child) {
                        return ListView.separated(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: selectedJobGroups.length,
                          separatorBuilder: (context, index) => const Gap(8),
                          itemBuilder: (context, index) {
                            final item = selectedJobGroups[index];
                            return Align(
                              child: ClosableRectFilledChip(
                                label: item.name,
                                onTap: () {
                                  onTapItem(item);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  double get maxExtent => selectedJobGroups.isNotEmpty ? expandedHeight : 12;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SelectedJobGroupListViewDelegate oldDelegate) {
    return this != oldDelegate;
  }
}
