import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';

class AllButton extends StatelessWidget {
  const AllButton({
    super.key,
    required this.onTap,
    this.label = LocaleKeys.youtubeDetail_seeAll,
  });

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppColor.of.gray2,
          ),
        ),
        child: Text(
          tr(label),
          style: AppTextStyle.alert1.copyWith(
            color: AppColor.of.gray5,
          ),
        ),
      ),
    );
  }
}
