import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class RoundedRectFilledChip extends StatelessWidget {
  const RoundedRectFilledChip({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColor.of.brand2,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 8.h,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: AppTextStyle.body1.copyWith(
                  color: Colors.white,
                ),
              ),
              WidthBox(2.w),
              FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                color: Colors.white,
                size: 16.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
