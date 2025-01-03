import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_text_style.dart';

class TechtalkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TechtalkAppBar(
      {super.key, required this.title, this.actions, this.padding});

  final String title;
  final List<Widget>? actions;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: 56,
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
    return AppBar(
      title: Text(
        title,
        style: AppTextStyle.headline2,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
