import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';

class FrequentlyWrongAnswerIndicator extends StatelessWidget {
  const FrequentlyWrongAnswerIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 7, 8, 7),
        decoration: BoxDecoration(
          color: AppColor.of.red1,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.iconsRedAlert),
            const Gap(2),
            Text(
              context.tr(LocaleKeys.mistakeNote_wrongManyTimes),
              style: AppTextStyle.body3.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.of.red2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
