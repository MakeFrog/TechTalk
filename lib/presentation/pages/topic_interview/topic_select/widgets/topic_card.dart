import 'package:flutter/material.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    super.key,
    this.isSelected = false,
    this.onTap,
  });

  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColor.of.brand2.withOpacity(0.07)
          : AppColor.of.background1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          width: 3,
          color: isSelected ? AppColor.of.brand2 : Colors.transparent,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  Assets.imagesTopicFlutter,
                ),
              ),
              const HeightBox(16),
              Text(
                'Flutter',
                style: AppTextStyle.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
