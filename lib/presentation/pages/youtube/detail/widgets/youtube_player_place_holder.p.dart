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
    return YoutubeValueBuilder(
      controller: youtubeController(ref),
      builder: (context, value) {
        return HookBuilder(
          builder: (context) {
            final state = useState(YoutubePlaySate.unStarted);
            final timer = useState<Timer?>(null); // 타이머를 관리

            useEffect(() {
              // 상태가 변경될 때 실행되는 로직
              final changedState =
                  YoutubePlaySate.fromCode(value.playerState.code);

              if (state.value != changedState) {
                state.value = changedState;
                // unStarted 상태에서 cued로 변경되기 전에 타이머 설정
                if (changedState == YoutubePlaySate.unStarted ||
                    changedState == YoutubePlaySate.unknown) {
                  timer.value?.cancel(); // 기존 타이머 취소
                  /// [NOTE]
                  /// 2초가 지나도 [cued] 상태로 변경되지 않는다면,
                  /// iframe으로 지원하지 않는 영상이라고 판단
                  timer.value = Timer(const Duration(seconds: 3), () {
                    if (state.value != YoutubePlaySate.cued) {
                      state.value = YoutubePlaySate
                          .errorOccured; // cued로 변하지 않으면 에러 상태로 변경
                      timer.value?.cancel();
                      // 다른 상태가 되면 타이머 취소
                    }
                  });
                } else {
                  timer.value?.cancel();
                }
              }

              return () => timer.value?.cancel(); // 컴포넌트 dispose 시 타이머 취소
            }, [value.playerState]);

            // 상태에 따라 다른 위젯 반환
            if (state.value == YoutubePlaySate.unStarted ||
                state.value == YoutubePlaySate.unknown ||
                state.value == YoutubePlaySate.cued) {
              return AspectRatio(
                aspectRatio: 9 / 16,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      AsyncSkeletonWidgetBuilder(
                        asyncValue: mainInfo(ref),
                        dataBuilder: (context, info) {
                          return Image.network(
                            info.thumbnailImgUrl,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                      const Positioned.fill(
                        child: ColoredBox(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ),
                      Center(
                        child: Builder(
                          builder: (context) {
                            if (state.value == YoutubePlaySate.cued) {
                              return IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  Assets.iconsPlay,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state.value == YoutubePlaySate.errorOccured) {
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
            } else {
              return const IgnorePointer(
                child: EmptyBox(),
              );
            }
          },
        );
      },
    );
  }
}
