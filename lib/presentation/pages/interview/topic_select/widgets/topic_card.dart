import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/entities/interview_topic.enum.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    super.key,
    required this.topic,
    this.isSelected = false,
    this.isLoaded = true,
    this.onTap,
  });

  final InterviewTopic? topic;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isLoaded;

  factory TopicCard.createSkeleton() => const TopicCard(
        topic: null,
        isLoaded: false,
      );

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
        onTap: isLoaded ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: isLoaded
              ? Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        topic!.imageUrl!,
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
                    const Gap(16),
                    Text(
                      topic!.name,
                      style: AppTextStyle.headline3,
                    ),
                  ],
                )
              : const EmptyBox(),
        ),
      ),
    );
  }
}
