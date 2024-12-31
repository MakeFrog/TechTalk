import 'package:flutter/animation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/contents/usecases/get_qnas_from_youtube_content_use_case.dart';
import 'package:techtalk/features/contents/usecases/get_summary_from_youtube_content_use_case.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/target_youtube_info_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/upload_step_page_controller.dart';

mixin class YoutubeContentUploadEvent {
  ///
  /// [_UrlInputView] > 첫 번째 단계에서 '다음(확인)' 버튼이 클릭되었을 때
  ///
  void onUrlOrIdConfirmBtnTapped(WidgetRef ref) {
    final pageController = ref.read(uploadStepPageControllerProvider);
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  //// 비디오 정보를 호출하는데 성공 했을 때
  void onVideoFetchConfirmed(WidgetRef ref) {
    final pageController = ref.read(uploadStepPageControllerProvider);
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  ///
  /// 뒤로가기 버튼이 클릭 되었을 때
  ///
  Future<void> onBackBtnTapped(WidgetRef ref) async {
    final pageController = ref.read(uploadStepPageControllerProvider);
    final currentPageIndex = pageController.page?.toInt() ?? 0;

    switch (currentPageIndex) {
      case 0:
        ref.context.pop();
        break;

      case 1:

        /// 분석 화면
        /// TODO : XIMYA 분석도중 이탈 시 어떻게 처리할지 기획적 고민필요
        /// 아래는 임시코드

        await pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeIn,
        );
        break;

      case 2:
        await pageController.animateToPage(
          0,
          duration: const Duration(microseconds: 1),
          curve: Curves.easeIn,
        );
        break;

      case 3:

        /// 분석 화면
        /// TODO: 영상 업로드 도중 이탈 시 어떻게 처리할지 기획적 고민필요
        await pageController.animateToPage(
          0,
          duration: const Duration(microseconds: 1),
          curve: Curves.easeIn,
        );
        break;

      default:
        ref.context.pop();
    }
  }

  ///
  /// 영상 확인 단계에서
  /// '다음' (영상 분석 시작) 버튼이 클릭 되었을 때
  ///
  void onStartAnalyzedBtnTapped(WidgetRef ref) {
    final pageController = ref.read(uploadStepPageControllerProvider);
    pageController.animateToPage(
      3,
      duration: const Duration(microseconds: 1),
      curve: Curves.easeIn,
    );
  }
}
