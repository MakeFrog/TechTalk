import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/pages/interview/select_commotion_interview_type/selected_common_interview_type_event.dart';
import 'package:techtalk/presentation/pages/interview/select_commotion_interview_type/selected_common_interview_type_state.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class SelectedCommonInterviewTypePage extends BasePage
    with SelectedCommonInterviewTypeState, SelectedCommonInterviewTypeEvent {
  const SelectedCommonInterviewTypePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(16),
          Text(
            '면접 질문 유형을\n선택해보세요',
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            '실제 면접에서 자주 나오는 질문들을 모아두었어요',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
          const Spacer(flex: 149),
          Row(
            children: [
              _buildInterviewTypeCard(
                title: '실전형',
                description: '여러 주제를 선택해\n실전 연습을 해보세요',
                onTap: () => routeToTopicSelectPage(
                  context,
                  type: InterviewType.commonPracticalTopic,
                ),
                isPractical: true,
              ),
              const Gap(16),
              _buildInterviewTypeCard(
                title: '주제별',
                description: '하나의 주제를 선택해\n집중 공략해 보세요',
                onTap: () => routeToTopicSelectPage(
                  context,
                  type: InterviewType.commonSingleTopic,
                ),
                isPractical: false,
              ),
            ],
          ),
          const Spacer(flex: 215),
        ],
      ),
    );
  }

  Widget _buildInterviewTypeCard({
    required String title,
    required String description,
    required VoidCallback onTap,
    required bool isPractical,
  }) {
    return Expanded(
      child: BounceTapper(
        highlightBorderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColor.of.gray1),
          ),
          child: Column(
            children: [
              const Gap(28),
              Text(
                title,
                style: AppTextStyle.headline2.copyWith(
                  color: AppColor.of.gray6,
                ),
              ),
              const Gap(4),
              Text(
                description,
                style: AppTextStyle.body3.copyWith(
                  color: AppColor.of.gray4,
                  height: 1.4,
                ),
              ),
              const Gap(12),
              Transform.translate(
                offset: const Offset(0, 4),
                child: SvgPicture.asset(
                  width: (AppSize.screenWidth - 48) / 2,
                  isPractical
                      ? Assets.iconsCommonPracticalTypeIllust
                      : Assets.iconsCommonSingleTypeIllust,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}
