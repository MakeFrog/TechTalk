import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:techtalk/app/style/app_color.dart';

final _switchAnimationDuration = 200.ms;
const _switchAnimationCurve = Curves.bounceInOut;

class FlatSwitch extends StatelessWidget {
  const FlatSwitch({
    super.key,
    required this.value,
    required this.onTap,
    this.height = 22,
    this.width = 38,
    this.dotSize = 18,
    this.bgColor = const Color(0xFF3446EA),
    this.disabledBgColor = const Color(0xFFDCDCE9),
    this.dotColor = Colors.white,
  });

  final void Function(bool value) onTap;
  final bool value;
  final double height;
  final double width;
  final double dotSize;
  final Color bgColor;
  final Color disabledBgColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!value),
      child: AnimatedContainer(
        duration: _switchAnimationDuration,
        curve: _switchAnimationCurve,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: value ? bgColor : disabledBgColor,
          borderRadius: BorderRadius.circular(64),
        ),
        padding: const EdgeInsets.all(3),
        child: AnimatedAlign(
          duration: _switchAnimationDuration,
          curve: _switchAnimationCurve,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: dotSize,
            width: dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
            ),
          ),
        ),
      ),
    );
  }
}
