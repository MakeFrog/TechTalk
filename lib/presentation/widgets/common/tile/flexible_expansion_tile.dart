import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///
/// [ExpansionTile] 과 유사한 쓰임새를 가지는 위젯
/// 기존 모듈모다 커스텀한 UI를 적용하기 위해 해당 모듈을 구현함.
///

class FlexibleExpansionTile extends HookWidget {
  final Widget title; // 제목, 상단에 위치
  final Widget content; // 본문, 확장 되었을 때 노출
  final EdgeInsets? padding; // 패딩
  final Alignment alignment; // 정렬
  final Duration duration; // 확장 애니메이션의 시간
  final Duration? reverseDuration; // 축소 역방향 애니메이션의 기간
  final Curve curve; // 애니메이션의 곡선
  final Curve reverseCurve; // 역방향 애니메이션의 곡선
  final ValueNotifier<bool>? isExpanded; // 확장 여부 state
  final bool isExpandedInitially; // 초기 확장 상태

  const FlexibleExpansionTile({
    Key? key,
    required this.title,
    required this.content,
    this.padding,
    this.isExpanded,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration,
    this.curve = Curves.easeOut,
    this.reverseCurve = Curves.easeIn,
    this.isExpandedInitially = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// title의 확장 여부
    /// 생성자로부터 전달 받은 상태 값이 있다면 해당 값을 사용
    final isOpen = isExpanded ?? useState(isExpandedInitially);

    // 애니메이션 컨트롤러
    final animationController = useAnimationController(
      duration: duration,
      reverseDuration: reverseDuration ?? duration,
      initialValue: isOpen.value ? 1.0 : 0.0,
    );

    /// 애니메이션
    final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: curve,
        reverseCurve: reverseCurve,
      ),
    );

    // 확장 <--> 축소 상태 변경에 대한 효과
    useEffect(() {
      if (isOpen.value) {
        animationController.forward();
      } else {
        animationController.reverse();
      }

      return null;
    }, [isOpen.value, animationController]);

    return InkWell(
      onTap: () {
        isOpen.value = !isOpen.value; // 터치 시 상태 토글
      },
      child: Container(
        padding: padding,
        alignment: alignment,
        child: Column(
          children: [
            title, // 제목
            ClipRect(
              child: AnimatedBuilder(
                animation: animationController,
                builder: (_, child) {
                  return Align(
                    heightFactor: animation.value,
                    widthFactor: 1.0,
                    child: child,
                  );
                },
                child: content, // 내용
              ),
            ),
          ],
        ),
      ),
    );
  }
}
