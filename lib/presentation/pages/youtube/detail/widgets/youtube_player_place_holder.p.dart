part of '../youtube_detail_page.dart';

///
/// youtube iframe 위에 오버레이 되어 보여지는 place holder view
/// 딤, play, 로딩등의 ui들이
/// 유튜브 플레이어 상태 [YoutubePlayerState]에 따라 분기됨
///
class _YoutubePlayerPlaceHolder extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _YoutubePlayerPlaceHolder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IgnorePointer(
      child: Builder(builder: (context) {
        if (playerState(ref).isExceptionState) {
          return _buildExceptionView();
        } else if (!hasYoutubePlayerCued(ref)) {
          /// 로딩 뷰
          return AspectRatio(
            aspectRatio: 9 / 16,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  if (passedThumbnailImg(ref) != null)
                    _buildThumbnail(
                      context,
                      url: passedThumbnailImg(ref)!,
                    )
                  else
                    AsyncSkeletonWidgetBuilder(
                      asyncValue: mainInfo(ref),
                      skeletonBuilder: (_) =>
                          const ColoredBox(color: Colors.black),
                      dataBuilder: (context, info) {
                        return _buildThumbnail(
                          context,
                          url: info.thumbnailImgUrl,
                        );
                      },
                    ),
                  const Positioned.fill(
                    child: ColoredBox(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const EmptyBox();
        }
      }),
    );
  }

  ///
  /// 오류 및 여러 예외 경우가 발생했을 때
  /// 보여지는 뷰
  ///
  Widget _buildExceptionView() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber,
              size: 20,
              color: AppColor.of.gray4,
            ),
            const Gap(6),
            Text(
              '네트워크 상태가 좋지 않거나\n재생할 수 없는 영상입니다',
              textAlign: TextAlign.center,
              style: AppTextStyle.body1.copyWith(
                color: AppColor.of.gray4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// 썸네일
  ///
  Widget _buildThumbnail(BuildContext context, {required String url}) {
    return Image.network(
      cacheWidth: (AppSize.screenWidth / (16 / 9)).cacheSize(context),
      url,
      width: double.infinity,
      fit: BoxFit.fitWidth,
    );
  }
}
