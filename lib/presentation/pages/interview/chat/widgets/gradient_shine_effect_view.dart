import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Gradient 기반의 빛나는 효과가 적용된 뷰
///
/// 유저가 처음 면접을 시도했을 때
/// [_BottomTextField]의 '음성 인식' 활성화 버튼의 barckground view로 노출됨
///
class GradientShineEffectView extends StatefulWidget {
  const GradientShineEffectView({super.key});

  @override
  State<GradientShineEffectView> createState() => _GradientShineEffectViewState();
}

class _GradientShineEffectViewState extends State<GradientShineEffectView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // 애니메이션 속도 조정
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6D84FF),
                  Color(0xFF9175FF),
                ],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              backgroundBlendMode: BlendMode.srcATop,
            ),
            // 중간에 빛나는 느낌을 주기 위해 shader 추가
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.3),
                    Colors.transparent
                  ],
                  stops: const [0.1, 0.5, 1],
                  begin: Alignment.topLeft
                      .add(Alignment(_animation.value, _animation.value)),
                  end: Alignment.bottomRight
                      .add(Alignment(_animation.value, _animation.value)),
                ).createShader(rect);
              },
              child: Container(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
