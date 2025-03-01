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
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_state.dart';
import 'package:techtalk/presentation/pages/resume_manage/widgets/resume_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

part 'package:techtalk/presentation/pages/resume_manage/widgets/resume_manage_bottom_sheet.dart';

class ResumeManagePage extends BasePage
    with ResumeManageEvent, ResumeManageState {
  ResumeManagePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    // TODO: 여기서 ref.watch로 인해 무엇이 불필요하게 빌드되는지 궁금 (yundal)
    final data = ref.watch(resumeInfoProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildGuideText(),

          ResumeCard.resume(resume: data.requireValue!.resume),
          ResumeCard.portfolio(portfolio: data.requireValue!.portfolio),

          const Spacer(),

          /// 저장 버튼
          Column(
            children: [
              // if (showTooltip) ...[
              //   SvgPicture.asset(Assets.iconsOneMoreAddTooltip),
              //   const Gap(8),
              // ],
              BounceTapper(
                child: FilledButton(
                  onPressed:
                      isFileChanged(ref) ? () => onClickedSaveBtn(ref) : null,
                  child: Center(
                    child: Text(
                      context.tr(LocaleKeys.common_save),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar(title: '내 이력서');

  @override
  void onWillPop(WidgetRef ref) {
    debugPrint('뒤로가기 실행');
    super.onWillPop(ref);
  }
}
