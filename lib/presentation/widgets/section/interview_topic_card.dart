import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class InterviewTopicCard extends StatelessWidget {
  const InterviewTopicCard({
    super.key,
    required this.topic,
    this.isSelected = false,
    this.isLoaded = true,
    this.onTap,
  });

  final TopicEntity? topic;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isLoaded;

  factory InterviewTopicCard.createSkeleton() => const InterviewTopicCard(
        topic: null,
        isLoaded: false,
      );

  @override
  Widget build(BuildContext context) {
    final double _topicImgSize = AppSize.ratioHeight(72);

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
        onTap: isLoaded ? onTap : null,
        child: isLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _topicImgSize,
                    width: _topicImgSize,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_topicImgSize / 2),
                      child: Image.asset(
                        topic!.imageUrl!,
                        fit: BoxFit.cover,
                        color: isSelected
                            ? AppColor.of.brand2.withOpacity(0.07)
                            : null,
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
                  ),
                  const Gap(16),
                  Text(
                    topic!.text,
                    style: AppTextStyle.headline3,
                  ),
                ],
              )
            : const EmptyBox(),
      ),
    );
  }
}
