import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class BackButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackButtonAppBar({
    super.key,
    this.title,
    this.onBackBtnTapped,
    this.actions,
  });

  final String? title;
  final VoidCallback? onBackBtnTapped;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColor.of.white,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: 56,
      actions: actions,
      title: Text(
        title ?? '',
        style: AppTextStyle.headline2,
      ),
      leading: SizedBox(
        child: IconButton(
          onPressed: onBackBtnTapped ?? context.pop,
          icon: SvgPicture.asset(Assets.iconsArrowLeft),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
