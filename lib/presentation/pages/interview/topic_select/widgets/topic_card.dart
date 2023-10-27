import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    super.key,
    required this.topic,
    this.isSelected = false,
    this.onTap,
  });

  final InterviewTopicEntity topic;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColor.of.brand2.withOpacity(0.07)
          : AppColor.of.background1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          width: 3.w,
          color: isSelected ? AppColor.of.brand2 : Colors.transparent,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(28.r),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  topic.imageUrl!,
                  color:
                      isSelected ? AppColor.of.brand2.withOpacity(0.07) : null,
                  colorBlendMode: BlendMode.srcATop,
                  errorBuilder: (_, __, ___) => Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              HeightBox(16.h),
              Text(
                topic.name,
                style: AppTextStyle.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
