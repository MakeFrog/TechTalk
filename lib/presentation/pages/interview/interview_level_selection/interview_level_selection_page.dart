import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_level.enum.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/interview_level_selection_state.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

///
/// AI 면접 > 면접 질문 난이도 선택 페이지
///
class InterviewLevelSelectionPage extends BasePage
    with InterviewLevelSelectionState {
  const InterviewLevelSelectionPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            '면접 질문 난이도를\n선택해주세',
            style: AppTextStyle.headline1,
          ),
          const Gap(60),
          Expanded(
            child: Center(
              child: PageView.builder(
                  itemCount: InterviewLevel.values.length,
                  controller: pageController(ref),
                  itemBuilder: (context, index) {
                    final item = InterviewLevel.values[index];
                    return Column(
                      children: [
                        /// LEADING INDICIATOR
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColor.of.blue1,
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                          child: Text(
                            item.titleLabel,
                            style: AppTextStyle.title1.copyWith(
                              color: AppColor.of.blue3,
                            ),
                          ),
                        ),

                        const Gap(12),

                        /// DESCRIPTION
                        Text(
                          '한번 도전해 보세요',
                          style: AppTextStyle.body2.copyWith(
                            color: AppColor.of.gray4,
                          ),
                        ),
                        const Gap(12),
                        SvgPicture.asset(item.illustPath)
                      ],
                    );
                  }),
            ),
          ),

          /// LEVEL SELECTION BUTTON
          Row(
            children: [
              ...List.generate(InterviewLevel.values.length, (index) {
                final item = InterviewLevel.values[index];
                return Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(item.label),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
