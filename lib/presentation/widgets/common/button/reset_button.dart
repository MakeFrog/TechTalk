import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';

///
/// '초기화' 버튼
///
class ResetButton extends StatelessWidget {
  const ResetButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: onTap,
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColor.of.white,
          borderRadius: BorderRadius.circular(
            99,
          ),
          border: Border.all(
            color: AppColor.of.gray2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              Assets.iconsReset,
              width: 14,
              height: 14,
            ),
            const Gap(2),
            Text(
              '초기화',
              style: AppTextStyle.alert1.copyWith(color: AppColor.of.gray5),
            ),
          ],
        ),
      ),
    );
  }
}
