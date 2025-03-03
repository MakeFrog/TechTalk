import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

class ClosableFilledChip extends StatelessWidget {
  const ClosableFilledChip({
    super.key,
    required this.name,
    this.logoPath,
    this.onTap,
    this.height = 32,
  });

  final String name;
  final String? logoPath;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: logoPath != null
                    ? const EdgeInsets.symmetric(
                        horizontal: 8,
                      )
                    : const EdgeInsets.only(
                        left: 10,
                        right: 8,
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (logoPath != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: RoundedSkillImage(
                          imagePath: logoPath,
                          scale: 1.0,
                          disableRound: true,
                          size: 16,
                        ),
                      ),
                    Text(
                      name,
                      style: AppTextStyle.body1,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(4),
                    SvgPicture.asset(
                      Assets.iconsCircleSmallClose,
                      width: 16,
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColor.of.gray1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
