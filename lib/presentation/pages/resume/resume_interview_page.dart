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

class ResumeInterviewPage extends BasePage with ResumeEvent, ResumeState {
  ResumeInterviewPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return resumeAsync(ref).when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Text('에러가 발생했습니다'),
      data: (data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Gap(16),
              buildMainText(),
              buildGuideText(),
              ResumeCard.resume(resume: data?.resume),
              ResumeCard.portfolio(portfolio: data?.portfolio),
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
          '25MB 이하의 PDF 파일만 등록할 수 있어요',
          style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
        ),
        const Gap(12),
      ],
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // 최소 공간만 차지하도록
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showTooltip(ref)) ...[
                SvgPicture.asset(Assets.iconsOneMoreAddTooltip),
                const Gap(8),
              ],
              BounceTapper(
                child: FilledButton(
                  onPressed:
                      hasDocument(ref) ? () => startResumeInterview(ref) : null,
                  child: const Center(
                    child: Text('면접 시작하기'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      title: '',
      onBackBtnTapped: () {
        ref.invalidate(resumeInfoProvider);
        context.pop();
      },
    );
  }

  // 뒤로 가기 시점에 resumeInfoProvider 초기화
  @override
  bool get canPop => false;

  // 화면을 떠날 때 원하는 처리가 있다면 here
  @override
  void onWillPop(WidgetRef ref) {
    ref.invalidate(resumeInfoProvider);
    super.onWillPop(ref);
  }
}
