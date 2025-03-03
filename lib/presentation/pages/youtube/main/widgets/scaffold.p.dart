part of '../youtube_main_page.dart';

class _Scaffold extends HookConsumerWidget with YoutubeMainState {
  const _Scaffold({
    super.key,
    required this.categorySliderBar,
    required this.contentListView,
  });

  final Widget categorySliderBar;
  final Widget contentListView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 스크롤 방향에 따라 앱바를 숨기기 위한 AnimationController & 상태값
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
      initialValue: 1.0, // 초기에 노출된 상태
    );
    bool isAppBarHidden = false;
    double lastOffset = 0;

    final offsetAnimation = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0, -1.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // 가로 스크롤은 무시
        if (notification.metrics.axisDirection == AxisDirection.left ||
            notification.metrics.axisDirection == AxisDirection.right) {
          return false;
        }

        if (notification is ScrollStartNotification) {
          lastOffset = notification.metrics.pixels;
        } else if (notification is ScrollUpdateNotification) {
          final currentOffset = notification.metrics.pixels;
          final diff = currentOffset - lastOffset;
          final delta = notification.scrollDelta;

          if (currentOffset < 30) {
            if (isAppBarHidden && !animationController.isAnimating) {
              animationController.forward();
              isAppBarHidden = false;
            }

            lastOffset = currentOffset;
            return false;
          }

          if (!isAppBarHidden &&
              diff > 50 &&
              !animationController.isAnimating &&
              delta != null &&
              delta > 0) {
            animationController.reverse();
            isAppBarHidden = true;
            lastOffset = currentOffset;
          } else if (isAppBarHidden &&
              diff < -50 &&
              !animationController.isAnimating &&
              delta != null &&
              delta < 0) {
            animationController.forward();
            isAppBarHidden = false;
            lastOffset = currentOffset;
          }
        }

        return false;
      },
      child: Stack(
        children: [
          // 리스트/콘텐츠
          contentListView,
          // 앱바
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: offsetAnimation,
              child: categorySliderBar,
            ),
          ),
        ],
      ),
    );
  }
}
