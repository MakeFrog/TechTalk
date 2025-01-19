part of '../channel_detail_page.dart';

class _ChannelInfoView extends ConsumerWidget with ChannelDetailState {
  const _ChannelInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        RoundProfileImg(
          size: 64,
          imgUrl: channel(ref).logoUrl,
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              channel(ref).name,
              style: AppTextStyle.headline2,
            ),
          ],
        ),
      ],
    );
  }
}
