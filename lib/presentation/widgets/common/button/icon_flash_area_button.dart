import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// [IconButton]과 유사하게 작동하지만
/// 아이콘 사이즈는 고정되어 있고 Flash Area가 지정되어 있는 버튼
/// Flash Area는 사이즈 자체를 가지고 있지 않기 때문에
/// 넓은 터치 영역은 보장하면서, 유연하게 사이즈를 지정할 수 있음
///

class IconFlashAreaButton extends StatelessWidget {
  const IconFlashAreaButton({
    super.key,
    this.icon,
    this.iconPath,
    this.color = Colors.white,
    required this.size,
    required this.onTap,
  });

  final String? iconPath;
  final IconData? icon;
  final double size;
  final Color? color;
  final VoidCallback onTap;

  // Assets Icon 포맷
  factory IconFlashAreaButton.assetIcon({
    required String iconPath,
    required double size,
    required VoidCallback onIconTapped,
  }) =>
      IconFlashAreaButton(
        iconPath: iconPath,
        size: size,
        onTap: onIconTapped,
      );

  // Flutter Package Icon 포맷
  factory IconFlashAreaButton.packageIcon({
    Color? color = Colors.white,
    required IconData icon,
    required double size,
    required VoidCallback onIconTapped,
  }) =>
      IconFlashAreaButton(
        icon: icon,
        size: size,
        onTap: onIconTapped,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            child: iconPath != null
                ? SvgPicture.asset(
                    iconPath!,
                    height: size,
                    width: size,
                  )
                : Icon(
                    icon,
                    size: size,
                    color: color,
                  ),
          ),
          Positioned.fromRect(
            rect: Rect.fromPoints(
                Offset(-size, -size), Offset(size * 2, size * 2)),
            child: DeferPointer(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: onTap,
                child: Container(
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
