import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class StudyProgressIndicator extends StatelessWidget {
  const StudyProgressIndicator({
    super.key,
    required this.current,
    required this.maxCount,
  });

  final int current;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$current',
            style: AppTextStyle.body3.copyWith(
              color: AppColor.of.brand3,
            ),
          ),
          Text(
            ' / $maxCount 문항',
            style: AppTextStyle.body3.copyWith(
              color: AppColor.of.gray3,
            ),
          ),
        ],
      ),
    );
  }
}
