import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';

class ResumeInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const ResumeInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BounceTapper(
      // TODO: routeToChatListPage()에서 InterviewType.resume 새로 만든 후 적용하기
      onTap: () => onResumeCardTapped(ref),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
        decoration: BoxDecoration(
          color: AppColor.of.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    // TODO: Localization 적용하기
                    '이력서 면접',
                    style: AppTextStyle.headline2,
                  ),
                ),
                GestureDetector(
                  onTap: () => routeToResumeManagePage(context),
                  child: SvgPicture.asset(Assets.iconsRoundBlueCircle),
                ),
              ],
            ),
            // TODO: hasPracticalInterviewRecord 대신 Resume 전용 상태관리 적용하기
            if (!(user(ref)?.hasPracticalInterviewRecord ?? false))
              Padding(
                padding: const EdgeInsets.only(bottom: 12, right: 24),
                child: Text(
                  // TODO: Localization 적용하기
                  '이력서 면접 설명',
                  style: AppTextStyle.body1.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
