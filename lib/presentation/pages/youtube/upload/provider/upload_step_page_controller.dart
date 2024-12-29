import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/target_youtube_info_provider.dart';

part 'upload_step_page_controller.g.dart';

@riverpod
class UploadStepPageController extends _$UploadStepPageController {
  @override
  Raw<PageController> build() {
    final pageController = PageController();

    ref.onDispose(pageController.dispose);
    // pageController.addListener(() async {
    //   final int currentIndex = pageController.page?.toInt() ?? 0;
    //
    //   /// 초기 단계로 넘오왔을 경우에는
    //   /// [targetYoutubeInfoProvider] 데이터 초기화
    //   if (currentIndex == 0 && ref.exists(targetYoutubeInfoProvider)) {
    //     ref.read(targetYoutubeInfoProvider.notifier).refresh();
    //   }
    //
    //   if (currentIndex == 1) {
    //     /// 페이지뷰가 이동할 시간을 기다림
    //     await Future.delayed(const Duration(milliseconds: 500));
    //     await ref.read(targetYoutubeInfoProvider.notifier).fetchData();
    //   }
    // });

    return pageController;
  }
}
