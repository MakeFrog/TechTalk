part of '../youtube_detail_page.dart';

///
/// 콘테츠 정보를 노출하는 뷰
///
class _ContentInfoView extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _ContentInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        direction: Axis.vertical,
        children: [
          const Gap(16),
          AsyncSkeletonWidgetBuilder(
            asyncValue: mainInfo(ref),
            dataBuilder: (context, info) {
              return Row(
                children: [
                  Text(
                    AppFormatter.formatDurationLanguageFormat(
                      info.videoDuration,
                    ),
                    style: AppTextStyle.body2.copyWith(
                      color: AppColor.of.gray4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 12,
                    width: 1,
                    color: AppColor.of.gray2,
                  ),
                  Text(
                    tr(
                      LocaleKeys.youtubeDetail_questionsCount,
                      namedArgs: {
                        'count': info.qnaNum.toString(),
                      },
                    ),
                    style: AppTextStyle.body2.copyWith(
                      color: AppColor.of.gray4,
                    ),
                  ),
                ],
              );
            },
          ),

          const Gap(8),

          /// 제목 및 채널 정보
          Consumer(
            builder: (context, ref, _) {
              return AsyncSkeletonWidgetBuilder(
                  asyncValue: mainInfo(ref),
                  dataBuilder: (context, info) {
                    return Wrap(
                      direction: Axis.vertical,
                      children: [
                        SizedBox(
                          width: AppSize.screenWidth - 32,
                          child: Text(
                            info.contentsTitle,
                            style: AppTextStyle.headline2,
                          ),
                        ),
                        const Gap(8),
                        GestureDetector(
                          onTap: () {
                            onChannelSectionTapped(ref, channel: info.channel);
                          },
                          child: Row(
                            children: [
                              RoundProfileImg(
                                size: 30,
                                imgUrl: info.channel.logoUrl,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                info.channel.name,
                                style: AppTextStyle.body1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),

          const Gap(16),
          Consumer(
            builder: (context, ref, _) {
              return AsyncSkeletonWidgetBuilder(
                asyncValue: mainInfo(ref),
                dataBuilder: (context, mainInfo) {
                  return SizedBox(
                    width: AppSize.screenWidth - 32,
                    child: Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      children: [
                        ...mainInfo.relatedSkillIds
                            .map(
                              (skill) => OutlinedChip(
                                labelStyle: AppTextStyle.body3,
                                label: skill.name,
                              ),
                            )
                            .toList(),
                        ...mainInfo.relatedJobs
                            .map(
                              (job) => OutlinedChip(
                                labelStyle: AppTextStyle.body3,
                                label: job.name,
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
