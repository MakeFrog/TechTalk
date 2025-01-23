import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeDetailResourceProvider extends ChangeNotifier {
  /// 비디오 ID
  final String videoId;

  ///
  /// 유튜브 컨트롤러
  ///
  late final YoutubePlayerController youtubeController;

  //// 초기화
  void _onInit() async {
    /// [NOTE]
    /// youtube_iframe_plyaer 패키지 공식 문서를 보면
    /// 'YoutubePlayerController.fromVideoId()' 메소드로
    /// 컨트롤러를 초기화라고 기재되어 있지만, 이렇게 컨트롤러를 설정하면
    /// 15개중 2개의 영상이 재생이 안되는 현상이 발생함
    /// 공식문서에는 없지만 [cueVideoByUrl]로 초기화 시켜주어야 함.
    final controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        captionLanguage: AppLocale.currentLocale.languageCode,
        enableCaption: false,
        strictRelatedVideos: true,
        showFullscreenButton: true,
      ),
    );
    controller.cueVideoByUrl(
      mediaContentUrl: 'http://www.youtube.com/v/$videoId',
    );

    youtubeController = controller;
  }

  YoutubeDetailResourceProvider(this.videoId) {
    _onInit();
  }
}

final youtubeDetailResourceProvider = AutoDisposeChangeNotifierProviderFamily<
    YoutubeDetailResourceProvider, String>((ref, videoId) {
  final vm = YoutubeDetailResourceProvider(videoId);

  return vm;
});
