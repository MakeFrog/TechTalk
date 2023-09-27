import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/** Created By Ximya - 2022.11.05
 *  - [InkWell] 효과를 적용한 아이콘 버튼
 *  - [MaterialButton]를 기반으로 함
 *    - [MaterialButton]을 상속 받아서 모듈을 구성하려고 했지만 색상이 이상해지는 오류가 존재했었음.
 *  - [MaterialButton]의 기본 사이즈 및 패딩을 제거함.
 * */

class IconInkWellButton extends StatelessWidget {
  const IconInkWellButton({
    super.key,
    this.icon,
    this.iconPath,
    this.color = Colors.white,
    this.insets = 4,
    required this.size,
    required this.onIconTapped,
  });

  final String? iconPath;
  final IconData? icon;
  final double size;
  final Color? color;
  final VoidCallback onIconTapped;
  final double? insets;

  // Assets Icon 포맷
  factory IconInkWellButton.assetIcon(
          {required String iconPath,
          required double size,
          required VoidCallback onIconTapped,
          double? insets}) =>
      IconInkWellButton(
        iconPath: iconPath,
        size: size,
        onIconTapped: onIconTapped,
      );

  // Flutter Package Icon 포맷
  factory IconInkWellButton.packageIcon({
    Color? color = Colors.white,
    required IconData icon,
    required double size,
    required VoidCallback onIconTapped,
  }) =>
      IconInkWellButton(
        icon: icon,
        size: size,
        onIconTapped: onIconTapped,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      height: 0,
      padding: EdgeInsets.zero,
      onPressed: onIconTapped,
      child: iconPath != null
          ? Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                iconPath!,
                height: size,
                width: size,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                icon,
                size: size,
                color: color,
              ),
            ),
    );
  }
}
