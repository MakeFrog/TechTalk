import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';

class PracticalInterviewCard extends ConsumerWidget with HomeEvent {
  const PracticalInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: AppColor.of.brand1,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => onPracticalCardTapped(ref),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '실전형 면접',
                        style: AppTextStyle.headline2.copyWith(
                          color: AppColor.of.brand3,
                        ),
                      ),
                    ),
                    const Gap(48),
                    FaIcon(
                      FontAwesomeIcons.circlePlus,
                      color: AppColor.of.brand2,
                      size: 24,
                    ),
                  ],
                ),
                const Gap(12),
                Text(
                  '여러 주제를 선택해 실전 연습을 해보세요!',
                  style: AppTextStyle.body1.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
