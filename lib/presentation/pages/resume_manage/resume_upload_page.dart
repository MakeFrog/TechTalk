import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
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
    return const Placeholder();

    // debugPrint('===== ResumeUploadPage =====');

    // final tempState = fetchTempState(ref);
    // final localData = fetchLocalState(ref);

    // // 면접 시작하기 버튼 활성화
    // final bool isReadyToChat = localData.localResumePath.isNotEmpty ||
    //     localData.localPortfolioPath.isNotEmpty;
    // // tempState.isLocalResumeDeleted == true ||
    // // tempState.isLocalPortfolioDeleted == true;

    // return PopScope(
    //   onPopInvokedWithResult: (didPop, result) async {
    //     if (didPop) {
    //       ref.read(resumeTempDataInfoProvider.notifier).resetTempState();
    //     }
    //   },
    //   child: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             Text(
    //               '이력서나 포트폴리오를\n등록해 보세요',
    //               style: AppTextStyle.headline2,
    //             ),
    //             const Gap(12),
    //             Text(
    //               '50MB 이하의 PDF 파일만 등록할 수 있어요',
    //               style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
    //             ),
    //             const Gap(12),
    //             const _ResumePdfFileSection(),
    //             const _PortfolioPdfFileSection(),
    //           ],
    //         ),
    //         const Spacer(),

    //         // 저장 버튼
    //         Column(
    //           children: [
    //             if (shouldShowTooltip(
    //               tempState,
    //               localData,
    //               isTempChanged: isReadyToChat,
    //             ))
    //               Column(
    //                 children: [
    //                   SvgPicture.asset(Assets.iconsOneMoreAddTooltip),
    //                   const Gap(8),
    //                 ],
    //               ),
    //             BounceTapper(
    //               enable: isReadyToChat,
    //               child: FilledButton(
    //                 onPressed: isReadyToChat
    //                     ? ()
    //                         // TODO: 중괄호의 내용물은 startResumeInterview()에 넣을 예정 (yundal)
    //                         async {
    //                         // 일단 로딩중 페이지 이동
    //                         routeToResumeInterviewLoadingPage(ref);

    //                         // 저장하기 로직 실행
    //                         await onClickedSaveBtn(ref);

    //                         // pdf 경로 추출하기
    //                         final localResumePath = localData.localResumePath;
    //                         final localPortfolioPath =
    //                             localData.localPortfolioPath;

    //                         // pdf to txt
    //                         final String resumeContent =
    //                             await extractPdfToTxt(localResumePath);

    //                         final String portfolioContent =
    //                             await extractPdfToTxt(localPortfolioPath);

    //                         // 프롬프팅
    //                         await testSetAiResumeQuestionUseCase(
    //                           resumeContent,
    //                           portfolioContent,
    //                         );

    //                         // 완료시 다음 페이지 이동
    //                         await EasyLoading.show();
    //                         routeToResumeChatList(ref);
    //                         await EasyLoading.dismiss();
    //                       }
    //                     : null,
    //                 child: const Center(
    //                   child: Text('면접 시작하기'),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar(title: '');
}
