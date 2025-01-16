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

  ///
  /// 스크롤 컨트롤러
  ///
  late final ScrollController scrollController;

  //// 초기화
  void _onInit() {
    youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      params: YoutubePlayerParams(
        captionLanguage: AppLocale.currentLocale.languageCode,
        enableCaption: false,
        strictRelatedVideos: true,
        showFullscreenButton: true,
      ),
    );
    scrollController = ScrollController();
  }

  YoutubeDetailResourceProvider(this.videoId) {
    _onInit();
  }
}

final youtubeDetailResourceProvider = AutoDisposeChangeNotifierProviderFamily<
    YoutubeDetailResourceProvider,
    String>((ref, videoId) => YoutubeDetailResourceProvider(videoId));
