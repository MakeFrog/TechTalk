import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class PracticalInterviewCard extends StatelessWidget {
  const PracticalInterviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColor.of.brand1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '실전형 면접',
                  style: AppTextStyle.headline2.copyWith(
                    color: AppColor.of.brand3,
                  ),
                ),
              ),
              WidthBox(48.w),
              GestureDetector(
                onTap: () {},
                child: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  color: AppColor.of.brand2,
                  size: 24.w,
                ),
              ),
            ],
          ),
          HeightBox(12.h),
          Text(
            '여러 주제를 선택해 실전 연습을 해보세요!',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray3,
            ),
          ),
        ],
      ),
    );
  }
}
