import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';

class PracticalInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const PracticalInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: AppColor.of.brand1,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => onPracticalCardTapped(ref),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '실전형 면접',
                      style: AppTextStyle.headline2.copyWith(
                        color: AppColor.of.brand3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      routeToTopicSelectPage(
                        context,
                        type: InterviewType.practical,
                      );
                    },
                    child: SvgPicture.asset(Assets.iconsRoundBlueCircle),
                  ),
                ],
              ),
              if (!(user(ref)?.hasPracticalInterviewRecord ?? false))
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '여러 주제를 선택해 실전 연습을 해보세요!',
                    style: AppTextStyle.body1.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
