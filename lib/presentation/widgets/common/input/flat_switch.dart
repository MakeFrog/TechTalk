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
  });

  final void Function(bool value) onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!value),
      child: AnimatedContainer(
        duration: _switchAnimationDuration,
        curve: _switchAnimationCurve,
        height: 22,
        width: 40,
        decoration: BoxDecoration(
          color: value ? AppColor.of.brand3 : AppColor.of.gray2,
          borderRadius: BorderRadius.circular(11),
        ),
        padding: const EdgeInsets.all(3),
        child: AnimatedAlign(
          duration: _switchAnimationDuration,
          curve: _switchAnimationCurve,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: 22 - 2 * 3,
            width: 22 - 2 * 3,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
