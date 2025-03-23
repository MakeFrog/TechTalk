import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_state.dart';
import 'package:techtalk/presentation/pages/resume/widgets/resume_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class ResumeManagePage extends BasePage
    with ResumeManageEvent, ResumeManageState {
  ResumeManagePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return resumeAsync(ref).when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        debugPrint('resumeState error: $error');
        return const Center(child: Text('에러가 발생했습니다.'));
      },
      data: (doc) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Gap(16),
              buildGuideText(),
              ResumeCard.resume(resume: doc?.resume),
              ResumeCard.portfolio(portfolio: doc?.portfolio),
              const Spacer(),
              buildSaveBtn(ref),
            ],
          ),
        );
      },
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

  /// 저장 버튼
  Widget buildSaveBtn(WidgetRef ref) {
    return Column(
      children: [
        if (showTooltip(ref)) ...[
          SvgPicture.asset(Assets.iconsOneMoreAddTooltip),
          const Gap(8),
        ],
        BounceTapper(
          child: FilledButton(
            onPressed: isFileChanged(ref) ? () => onClickedSaveBtn(ref) : null,
            child: Center(
              child: Text(
                ref.context.tr(LocaleKeys.common_save),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      BackButtonAppBar(
        title: '내 이력서',
        onBackBtnTapped: () {
          ref.invalidate(resumeInfoProvider);
          ref.context.pop();
        },
      );

  @override
  void onWillPop(WidgetRef ref) {
    ref.invalidate(resumeInfoProvider);
    super.onWillPop(ref);
  }
}
