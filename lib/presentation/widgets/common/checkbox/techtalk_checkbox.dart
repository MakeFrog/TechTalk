import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';

class TechtalkCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size; // 박스 크기
  final Color activeBackgroundColor; // 활성화 백그라운드 컬러
  final Color inactiveBackgroundColor; // 비활성화 백그라운드 컬러
  final IconData activeIcon; // 활성화 시 아이콘
  final IconData inactiveIcon; // 비활성화 시 아이콘
  final double borderRadius; // 박스 모서리 radius
  final EdgeInsets? margin;

  const TechtalkCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.margin,
    this.activeBackgroundColor = const Color(0xFF5C6DFF),
    this.inactiveBackgroundColor = Colors.white,
    this.activeIcon = Icons.check,
    this.inactiveIcon = Icons.close,
    this.borderRadius = 4.62,
  }) : super(key: key);

  @override
  _TechtalkCheckBoxState createState() => _TechtalkCheckBoxState();
}

class _TechtalkCheckBoxState extends State<TechtalkCheckBox> {
  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      highlightColor: Colors.transparent,
      onTap: () {},
      child: AnimatedContainer(
        margin: widget.margin,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: widget.value
              ? widget.activeBackgroundColor
              : widget.inactiveBackgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.iconsWemoCheck,
            width: 18,
          ),
        ),
      ),
    );
  }
}
