import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseView extends HookConsumerWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 페이지의 초기화 및 해제를 처리
    useEffect(() {
      onInit(ref);
      return () => onDispose(ref);
    });

    /// 앱의 라이플 사이클 변화를 처리
    useOnAppLifecycleStateChange((previousState, state) {
      switch (state) {
        case AppLifecycleState.resumed:
          onResumed(ref);
          break;
        case AppLifecycleState.paused:
          onPaused(ref);
          break;
        case AppLifecycleState.inactive:
          onInactive(ref);
          break;
        case AppLifecycleState.detached:
          onDetached(ref);
          break;
        case AppLifecycleState.hidden:
        // TODO: Handle this case.
      }
    });

    return wrapWithSafeArea
        ? SafeArea(
            top: setTopSafeArea,
            bottom: setBottomSafeArea,
            child: buildView(context, ref))
        : buildView(context, ref);
  }

  /// SafeArea로 감싸는 여부를 설정
  @protected
  bool get wrapWithSafeArea => true;

  /// 뷰의 안전 영역 아래에 SafeArea를 적용할지 여부를 설정
  @protected
  bool get setBottomSafeArea => true;

  /// 뷰의 안전 영역 위에 SafeArea를 적용할지 여부를 설정
  @protected
  bool get setTopSafeArea => true;

  @protected
  Widget buildView(BuildContext context, WidgetRef ref);

  /// 앱이 활성화된 상태로 돌아올 때 호출
  @protected
  void onResumed(WidgetRef ref) {}

  /// 앱이 일시 정지될 때 호출
  @protected
  void onPaused(WidgetRef ref) {}

  /// 앱이 비활성 상태로 전환될 때 호출
  @protected
  void onInactive(WidgetRef ref) {}

  /// 앱이 분리되었을 때 호출
  @protected
  void onDetached(WidgetRef ref) {}

  /// 페이지 초기화 시 호출
  @protected
  void onInit(WidgetRef ref) {}

  /// 페이지 해제 시 호출
  @protected
  void onDispose(WidgetRef ref) {}
}
