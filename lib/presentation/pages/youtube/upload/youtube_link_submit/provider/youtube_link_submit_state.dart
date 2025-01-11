import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/modules/regex/app_validator.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_link_submit/provider/youtube_link_input_controller_provider.dart';

mixin class YoutubeLinkSubmitState {
  ///
  /// url 폼 키 (유효성 검증에 사용)
  ///
  GlobalKey formKey(WidgetRef ref) =>
      ref.read(youtubeLinkInputControllerProvider.notifier).formKey;

  ///
  /// url인풋 에디팅 컨트롤러
  ///
  TextEditingController textEditingController(WidgetRef ref) =>
      ref.watch(youtubeLinkInputControllerProvider);

  ///
  /// url 유효성 검사 로직
  /// 영상 id 값 또는 : xuc9C-C6Ldw
  /// 링크원본 : https://www.youtube.com/watch?v=xuc9C-C6Ldw
  ///
  String? urlInputValidator(String? input) {
    if (input?.isEmpty ?? false) {
      return '유튜브 영상의 링크 또는 id값을 입력해 주세요';
    }

    if (input!.trim().contains(' ')) {
      return '공백을 포함된 링크 또는 id는 입력할 수 없어요';
    }

    if (AppValidator.isValidUrl(input) &&
        !AppValidator.isYoutubeVideoUrl(input)) {
      return '입력 가능한 유튜브 영상 링크 또는 id가 아닙니다';
    }

    return null;
  }
}
