import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///
/// 렌더링이된 이후 아래에서 위로 올라오는 트랜지션이 적용된 뷰
///

class AnimatedAppearView extends HookWidget {
  const AnimatedAppearView({
    super.key,
    this.translateDuration,
    this.opacityDuration,
    this.awaitAppearDuration,
    this.curve,
    required this.child,
  });

  final Widget child;
  final Duration? translateDuration;
  final Duration? opacityDuration;
  final Duration? awaitAppearDuration;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    /// 애니메이션
    final isRendered = useState(false);

    // 애니메이션 컨트롤러
    final animationController = useAnimationController(
      duration: translateDuration ?? const Duration(milliseconds: 260),
      initialValue: isRendered.value ? 1.0 : 0.0,
    );

    final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: curve ?? Curves.easeOut,
      ),
    );

    /// 로딩 이후 자연스럽게 명함 카드 위젯을 노출하기 위해
    /// Opacity 애니메이션 조건 값 설정
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(awaitAppearDuration ?? Duration.zero);
        isRendered.value = true;
        animationController.forward();
      });

      return null;
    }, []);

    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Transform.translate(
          offset: Offset(
            0,
            (1 - animation.value) * 60,
          ),
          child: AnimatedOpacity(
            opacity: isRendered.value ? 1 : 0,
            duration: opacityDuration ?? const Duration(milliseconds: 310),
            child: child,
          ),
        );
      },
    );
  }
}
