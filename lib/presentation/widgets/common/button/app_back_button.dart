import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/widgets/common/button/icon_flash_area_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onBackBtnTapped,
  });

  final VoidCallback? onBackBtnTapped;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBackBtnTapped ?? context.pop,
      icon: SvgPicture.asset(
        Assets.iconsIconAppBarLeft,
        height: 24,
        width: 24,
      ),
    );
  }
}
