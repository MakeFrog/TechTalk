import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/services/app_size.dart';

///
/// 유튜브 콘텐츠 항목 뷰
///

class YoutubeContentItemView extends StatelessWidget {
  const YoutubeContentItemView({
    super.key,
    required this.thumbnailImgUrl,
    required this.title,
    required this.channelName,
  });

  final String thumbnailImgUrl;
  final String title;
  final String channelName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.of.gray1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 343 / 192,
              child: Image.network(
                thumbnailImgUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                minHeight: AppSize.ratioWidth(76),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.title1,
                  ),
                  const Gap(2),
                  Text(
                    channelName,
                    style: AppTextStyle.body2.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
