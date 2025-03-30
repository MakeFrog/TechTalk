import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/pages/interview/select_commotion_interview_type/selected_common_interview_type_event.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class SelectedCommonInterviewTypePage extends BasePage
    with SelectedCommonInterviewTypeEvent {
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
            tr(LocaleKeys.interview_interviewType_title),
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            tr(LocaleKeys.interview_interviewType_description),
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
          const Spacer(flex: 149),
          Row(
            children: [
              _buildInterviewTypeCard(
                title: tr(LocaleKeys.interview_interviewType_practical_title),
                description: tr(
                    LocaleKeys.interview_interviewType_practical_description),
                onTap: () => routeToTopicSelectPage(
                  context,
                  type: InterviewType.commonPracticalTopic,
                ),
                isPractical: true,
              ),
              const Gap(16),
              _buildInterviewTypeCard(
                title: tr(LocaleKeys.interview_interviewType_topic_title),
                description:
                    tr(LocaleKeys.interview_interviewType_topic_description),
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
