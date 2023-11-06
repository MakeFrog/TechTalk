import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';
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
    return Material(
      color: AppColor.of.brand2,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap,
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
              SvgPicture.asset(
                Assets.iconsRoundedCloseThick,
                width: 16.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
