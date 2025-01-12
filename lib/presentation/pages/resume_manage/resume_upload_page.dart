import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_temp_data_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class ResumeUploadPage extends BasePage
    with ResumeManageEvent, ResumeManageState {
  ResumeUploadPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    debugPrint('===== ResumeUploadPage =====');

    final tempState = fetchTempState(ref);
    final localData = fetchLocalState(ref);

    // 면접 시작하기 버튼 활성화
    final bool isReadyToChat = localData.localResumePath.isNotEmpty ||
        localData.localPortfolioPath.isNotEmpty;
    // tempState.isLocalResumeDeleted == true ||
    // tempState.isLocalPortfolioDeleted == true;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          ref.read(resumeTempDataInfoProvider.notifier).resetTempState();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '이력서나 포트폴리오를\n등록해 보세요',
                  style: AppTextStyle.headline2,
                ),
                const Gap(12),
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
            Column(
              children: [
                if (shouldShowTooltip(
                  tempState,
                  localData,
                  isTempChanged: isReadyToChat,
                ))
                  Column(
                    children: [
                      SvgPicture.asset(Assets.iconsOneMoreAddTooltip),
                      const Gap(8),
                    ],
                  ),
                BounceTapper(
                  enable: isReadyToChat,
                  child: FilledButton(
                    onPressed:
                        isReadyToChat ? () => startResumeInterview(ref) : null,
                    child: const Center(
                      child: Text('면접 시작하기'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar(title: '');
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
    final localState = fetchLocalState(ref);
    final bool isLocalResumeDataExist = localState.localResumePath.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('이력서', style: AppTextStyle.headline2),
          const Gap(8),
          if (tempState.tempResumePath == null &&
              tempState.isLocalResumeDeleted)
            FileUploadPlaceholder(
              onTap: () => resumePickAndSaveFile(ref),
            )
          else
            FileDisplayCard(
              isResume: true,
              localPath: localState.localResumePath,
              localTitle: localState.localResumeTitle,
              localDate: localState.localResumeDate,
              tempPath: tempState.tempResumePath,
              tempTitle: tempState.tempResumeTitle,
              tempDate: tempState.tempResumeDate,
              onFileTap: () => onRegisteredFileBtnTapped(
                ref,
                isResume: true,
                isLocal: isLocalResumeDataExist,
              ),
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
    final localState = fetchLocalState(ref);
    final bool isLocalPortfolioDataExist =
        localState.localPortfolioPath.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('포트폴리오', style: AppTextStyle.headline2),
          const Gap(8),
          if (tempState.tempPortfolioPath == null &&
              tempState.isLocalPortfolioDeleted)
            FileUploadPlaceholder(
              onTap: () => portfolioPickAndSaveFile(ref),
            )
          else
            FileDisplayCard(
              isResume: false,
              localPath: localState.localPortfolioPath,
              localTitle: localState.localPortfolioTitle,
              localDate: localState.localPortfolioDate,
              tempPath: tempState.tempPortfolioPath,
              tempTitle: tempState.tempPortfolioTitle,
              tempDate: tempState.tempPortfolioDate,
              onFileTap: () => onRegisteredFileBtnTapped(
                ref,
                isResume: false,
                isLocal: isLocalPortfolioDataExist,
              ),
              onEmptyTap: () => portfolioPickAndSaveFile(ref),
            ),
        ],
      ),
    );
  }
}
