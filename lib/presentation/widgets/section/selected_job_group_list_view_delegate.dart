import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
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
    return AnimatedSizeAndFade.showHide(
      sizeDuration: const Duration(milliseconds: 400),
      fadeDuration: const Duration(milliseconds: 200),
      show: selectedJobGroups.isNotEmpty,
      child: Container(
        color: AppColor.of.white,
        height: selectedJobGroups.isNotEmpty ? expandedHeight : 0,
        child: ListView.separated(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: selectedJobGroups.length,
          separatorBuilder: (context, index) => const Gap(8),
          itemBuilder: (context, index) {
            try {
              final item = selectedJobGroups[index];
              return Align(
                child: ClosableRectFilledChip(
                  label: AppLocale.isKo ? item.name : item.enName,
                  onTap: () {
                    onTapItem(item);
                  },
                ),
              );
            } catch (e) {
              /// NOTE
              /// [AnimatedSizeAndFade]에 걸려 있는 duration fade 때문에,
              /// 타겟하고 있는 배열에 더 이상 원소가 없을 경우 Range에러가 발생하는데
              /// 기능에 영향을 끼치지 않고 예상 가능한 오류라 이렇게 핸들링함.
              if (e is RangeError) {
                log('오류가 아님 : $e');
              }
            }
          },
        ),
      ),
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
