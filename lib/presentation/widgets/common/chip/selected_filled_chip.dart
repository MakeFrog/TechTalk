import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SelectedFilledChip extends StatelessWidget {
  const SelectedFilledChip({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 20,
      decoration: BoxDecoration(
        color: AppColor.of.brand2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: PretendardTextStyle.body1.copyWith(
                  color: Colors.white,
                ),
              ),
              const WidthBox(2),
              if (onTap != null)
                const FaIcon(
                  FontAwesomeIcons.solidCircleXmark,
                  color: Colors.white,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
