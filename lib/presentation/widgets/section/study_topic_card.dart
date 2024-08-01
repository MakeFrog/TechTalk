import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class StudyTopicCard extends StatelessWidget {
  const StudyTopicCard({
    super.key,
    required this.topic,
    this.onTap,
  });

  final TopicEntity topic;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double _topicImgSize = AppSize.to.ratioWidth(72);

    return ShrinkGestureView(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.of.background1,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                topic.text,
                style: AppTextStyle.headline3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: _topicImgSize,
                height: _topicImgSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_topicImgSize / 2),
                  child: Image.asset(
                    topic.imageUrl!,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
