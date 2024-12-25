import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';

///
/// [SkillEntity] 이미지를 보여주는 원형 뷰
///
class RoundedSkillImage extends StatelessWidget {
  const RoundedSkillImage({super.key, required this.imagePath, this.size = 20});

  final String? imagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: ColoredBox(
        color: AppColor.of.white,
        child: Transform.scale(
          scale: 1.1,
          child: SizedBox(
            width: size,
            height: size,
            child: Image.asset(
              imagePath?.skillImagePathPrefix ?? Assets.imagesAppIcon,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => ColoredBox(
                color: Colors.white,
                child: Image.asset(
                  Assets.imagesAppIcon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
