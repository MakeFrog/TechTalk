import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
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
      return tr(LocaleKeys.youtubeUpload_emptyInput);
    }

    if (input!.trim().contains(' ')) {
      return tr(LocaleKeys.youtubeUpload_containsSpace);
    }

    return null;
  }
}
