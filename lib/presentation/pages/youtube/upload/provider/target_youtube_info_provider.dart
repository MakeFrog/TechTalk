import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_entity.dart';
import 'package:techtalk/features/contents/youtube.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/upload_step_page_controller.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/url_input_text_editing_controller_provider.dart';

part 'target_youtube_info_provider.g.dart';

@riverpod
class TargetYoutubeInfo extends _$TargetYoutubeInfo {
  @override
  Future<YoutubeVideoEntity> build() async {
    final videoId = ref.read(urlInputTextEditingControllerProvider).text;
    final response = await youtubeRepository.getVideoAndCaption(videoId);
    return response.fold(onSuccess: (e) async {
      final pageController = ref.read(uploadStepPageControllerProvider);
      await pageController.animateToPage(2,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      return e;
    }, onFailure: (e) {
      log('유튜브 explore 데이터 호출 실패');
      throw e;
    });
  }
}
