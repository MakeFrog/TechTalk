import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_text_style.dart';

class TechtalkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TechtalkAppBar({
    super.key,
    required this.title,
    this.actions,
    this.padding,
    this.bgColor,
  });

  final String title;
  final List<Widget>? actions;
  final EdgeInsets? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: 56,
        color: bgColor,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyle.headline2,
            ),
            const Spacer(),
            ...?actions,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
