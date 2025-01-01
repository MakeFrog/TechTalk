import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/modules/regex/app_validator.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/analyzed_youtube_content_fetcher_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/target_youtube_info_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/upload_step_page_controller.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/url_input_text_editing_controller_provider.dart';

mixin class YoutubeContentUploadState {
  ///
  /// 페이지뷰 컨트롤러
  ///
  PageController pageController(WidgetRef ref) =>
      ref.watch(uploadStepPageControllerProvider);

  ///
  /// url인풋 에디팅 컨트롤러
  ///
  TextEditingController textEditingController(WidgetRef ref) =>
      ref.watch(urlInputTextEditingControllerProvider);

  ///
  /// url 유효성 검사 로직
  /// 영상 id 값 또는 : xuc9C-C6Ldw
  /// 링크원본 : https://www.youtube.com/watch?v=xuc9C-C6Ldw
  ///
  String? urlInputValidator(String? input) {
    if (input?.isEmpty ?? false) {
      return '영상의 링크 또는 고유한 id값을 입력해 주세요';
    }
    if (AppValidator.isValidUrl(input) && !AppValidator.isYoutubeUrl(input)) {
      return '지원하지 않는 영상 플랫폼 링크 입니다';
    }

    return null;
  }

  ///
  /// url 폼 키 (유효성 검증에 사용)
  ///
  GlobalKey formKey(WidgetRef ref) =>
      ref.read(urlInputTextEditingControllerProvider.notifier).formKey;

  ///
  /// 현재 입력된 url 또는 id
  ///
  String currentUrlOrId(WidgetRef ref) =>
      ref.read(urlInputTextEditingControllerProvider).text;

  ///
  /// 업로드할 유튜브 콘텐츠
  ///
  AsyncValue<YoutubeVideoEntity> targetYoutubeInfoAsync(WidgetRef ref) =>
      ref.watch(targetYoutubeInfoProvider);

  ///
  /// 분석 진행중인 유튜브 fetcher
  ///
  /// [NOTE]
  /// 값을 리턴하지 않고 provider 안에서 로직을 처리함.
  ///
  AsyncValue<void> analyzedYoutubeFetcherAsync(WidgetRef ref) {
    return ref.watch(analyzedYoutubeFetcherProvider);
  }
}
