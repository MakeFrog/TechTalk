part of '../youtube_detail_page.dart';

class _ContentInfoView extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _ContentInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Wrap(
        runSpacing: 5,
        children: [
          Consumer(
            builder: (context, ref, _) {
              return AsyncSkeletonWidgetBuilder(
                asyncValue: mainInfo(ref),
                dataBuilder: (context, mainInfo) => Text(
                  mainInfo.contentsTitle,
                  style: AppTextStyle.headline3,
                ),
              );
            },
          ),
          AsyncSkeletonWidgetBuilder(
            asyncValue: mainInfo(ref),
            dataBuilder: (context, mainInfo) => Row(
              children: [
                CircleAvatar(
                  backgroundImage:

                      /// TODO : XIMYA
                      /// 예외처리 모듈 만들기
                      NetworkImage(mainInfo.channel.logoUrl ?? ''),
                  radius: 15,
                ),
                const SizedBox(width: 8),
                Text(
                  mainInfo.channel.name,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              return AsyncSkeletonWidgetBuilder(
                  asyncValue: mainInfo(ref),
                  dataBuilder: (context, mainInfo) {
                    return Wrap(
                      spacing: 8.0,
                      children: [
                        ...mainInfo.relatedSkillIds
                            .map(
                              (skill) => Chip(label: Text(skill.name)),
                            )
                            .toList(),
                        ...mainInfo.relatedJobs
                            .map(
                              (job) => Chip(label: Text(job.name)),
                            )
                            .toList(),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
