import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

part 'package:techtalk/presentation/pages/resume_manage/widgets/file_display_card.dart';

class ResumeManagePage extends BasePage
    with ResumeManageEvent, ResumeManageState {
  ResumeManagePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final tempResumePath = fetchTempState(ref).tempResumePath;
    final tempPortfolioPath = fetchTempState(ref).tempPortfolioPath;

    // 저장하기 버튼 활성화
    final bool isTempChanged =
        tempResumePath != null || tempPortfolioPath != null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '50MB 이하의 PDF 파일만 등록할 수 있어요',
                style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
              ),
              const Gap(12),
              const _ResumePdfFileSection(),
              const _PortfolioPdfFileSection(),
            ],
          ),
          const Spacer(),

          // 저장 버튼
          BounceTapper(
            enable: isTempChanged,
            child: FilledButton(
              onPressed: isTempChanged 
              ? () => onClickedSaveButton(ref)
              : null,
              child: Center(
                child: Text(
                  context.tr(
                    LocaleKeys.common_save,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar(title: '내 이력서');
}

///
/// 이력서 섹션
///
class _ResumePdfFileSection extends ConsumerWidget
    with ResumeManageEvent, ResumeManageState {
  const _ResumePdfFileSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempState = fetchTempState(ref);
    final localState = fetchLocalData(ref);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('이력서', style: AppTextStyle.headline2),
          const Gap(8),
          FileDisplayCard(
            isResume: true,
            localPath: localState.localResumePath,
            localTitle: localState.localResumeTitle,
            localDate: localState.localResumeDate,
            tempPath: tempState.tempResumePath,
            tempTitle: tempState.tempResumeTitle,
            tempDate: tempState.tempResumeDate,
            onFileTap: () => onRegisteredFileBtnTapped(ref, isResume: true),
            onEmptyTap: () => resumePickAndSaveFile(ref),
          ),
        ],
      ),
    );
  }
}

///
/// 포트폴리오 섹션
///
class _PortfolioPdfFileSection extends ConsumerWidget
    with ResumeManageEvent, ResumeManageState {
  const _PortfolioPdfFileSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempState = fetchTempState(ref);
    final localState = fetchLocalData(ref);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('포트폴리오', style: AppTextStyle.headline2),
          const Gap(8),
          FileDisplayCard(
            isResume: false,
            localPath: localState.localPortfolioPath,
            localTitle: localState.localPortfolioTitle,
            localDate: localState.localPortfolioDate,
            tempPath: tempState.tempPortfolioPath,
            tempTitle: tempState.tempPortfolioTitle,
            tempDate: tempState.tempPortfolioDate,
            onFileTap: () => onRegisteredFileBtnTapped(ref, isResume: false),
            onEmptyTap: () => portfolioPickAndSaveFile(ref),
          ),
        ],
      ),
    );
  }
}
