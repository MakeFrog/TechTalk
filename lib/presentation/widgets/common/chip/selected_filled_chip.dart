import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SelectedFilledChip extends StatelessWidget {
  const SelectedFilledChip({
    super.key,
    required this.label,
    this.onTapXMark,
  });

  final String label;
  final VoidCallback? onTapXMark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColor.of.brand2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        height: 20,
        child: Row(
          children: [
            Text(
              label,
              style: PretendardTextStyle.body1.copyWith(
                color: Colors.white,
              ),
            ),
            WidthBox(2),
            if (onTapXMark != null)
              GestureDetector(
                onTap: onTapXMark,
                child: FaIcon(
                  FontAwesomeIcons.solidCircleXmark,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
