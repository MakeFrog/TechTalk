import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///
/// 스크롤 포지션을 offset을 기준점으로
/// 컬러가 변경되는 박스 뷰
///
class ScrollCameleonBox extends HookWidget {
  const ScrollCameleonBox({
    super.key,
    required this.height,
    required this.color,
    required this.colorAfterScroll,
    required this.scrollController,
    required this.animatedPosition,
    this.forwardDuration = const Duration(milliseconds: 200),
    this.reverseDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  final Duration forwardDuration;
  final Duration reverseDuration;
  final ScrollController scrollController;
  final Color color;
  final Color colorAfterScroll;
  final double animatedPosition;
  final double height;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final isScroll = useState(false);

        // 애니메이션 컨트롤러 생성
        final animationController = useAnimationController(
          duration: forwardDuration,
          reverseDuration: reverseDuration,
        );

        scrollController.addListener(() {
          final scrollPosition = scrollController.offset;

          if (animatedPosition < scrollPosition && !isScroll.value) {
            isScroll.value = true;
            animationController.forward();
            return;
          }

          if (animatedPosition >= scrollPosition && isScroll.value) {
            isScroll.value = false;
            animationController.reverse();
            return;
          }
        });

        return AnimatedContainer(
          height: height,
          width: double.infinity,
          color: isScroll.value ? colorAfterScroll : color,
          duration: forwardDuration,
          child: AnimatedOpacity(
            opacity: isScroll.value ? 0 : 1,
            duration: forwardDuration,
          ),
        );
      },
    );
  }
}
