import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

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
    return Material(
      clipBehavior: Clip.antiAlias,
      color: AppColor.of.background1,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  topic.name,
                  style: AppTextStyle.headline3,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 72,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(72),
                    child: CachedNetworkImage(
                      height: 72,
                      width: 72,
                      imageUrl: topic.imageUrl,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
