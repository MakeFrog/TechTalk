import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_state.dart';
import 'package:techtalk/presentation/pages/resume/widgets/resume_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class ResumeInterviewPage extends BasePage
    with ResumeManageEvent, ResumeManageState {
  ResumeInterviewPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return resumeAsync(ref).when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Text('에러가 발생했습니다'),
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildMainText(),

              buildGuideText(),

              ResumeCard.resume(resume: data?.resume),
              ResumeCard.portfolio(portfolio: data?.portfolio),

              const Spacer(),

              /// 면접 시작하기 버튼
              buildStartInterviewBtn(ref),
            ],
          ),
        );
      },
    );
  }

  /// 메인 텍스트
  Widget buildMainText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '이력서나 포트폴리오를\n등록해 보세요',
          style: AppTextStyle.headline1,
        ),
        const Gap(12),
      ],
    );
  }

  /// 가이드 텍스트
  Widget buildGuideText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '50MB 이하의 PDF 파일만 등록할 수 있어요',
          style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
        ),
        const Gap(12),
      ],
    );
  }

  /// 면접 시작하기 버튼
  Widget buildStartInterviewBtn(WidgetRef ref) {
    return Column(
      children: [
        // if 문으로 조건 처리
        if (showTooltip(ref)) ...[
          // 툴팁 UI 표시
          SvgPicture.asset(Assets.iconsOneMoreAddTooltip),
          const Gap(8),
        ],
        BounceTapper(
          child: FilledButton(
            onPressed: hasData(ref) ? () => startResumeInterview(ref) : null,
            child: const Center(
              child: Text('면접 시작하기'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      BackButtonAppBar(
        title: '',
        onBackBtnTapped: () {
          ref.invalidate(resumeInfoProvider);
          ref.context.pop();
        },
      );

  @override
  bool get canPop => false;
}
