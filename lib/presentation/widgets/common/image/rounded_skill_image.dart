import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

///
/// [SkillEntity] 이미지를 보여주는 원형 뷰
///
class RoundedSkillImage extends StatelessWidget {
  const RoundedSkillImage({
    super.key,
    required this.imagePath,
    this.size = 20,
    this.disableRound = false,
    this.borderRadius,
    this.scale = 1.1,
  });

  final String? imagePath;
  final double size;
  final bool disableRound;
  final BorderRadius? borderRadius;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ??
          (disableRound ? BorderRadius.zero : BorderRadius.circular(size / 2)),
      child: ColoredBox(
        color: AppColor.of.white,
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width: size,
            height: size,
            child: Builder(
              builder: (context) {
                try {
                  return Image.asset(
                    imagePath?.skillImagePathPrefix ?? Assets.imagesAppIcon,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => KeepAliveView(
                      child: ColoredBox(
                        color: Colors.white,
                        child: Image.asset(
                          Assets.imagesAppIcon,
                        ),
                      ),
                    ),
                  );
                } catch (e) {
                  debugPrint("Image loading error: $e");
                  return ColoredBox(
                    color: Colors.white,
                    child: Image.asset(
                      Assets.imagesAppIcon,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
