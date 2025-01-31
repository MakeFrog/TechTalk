part of '../channel_detail_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold(
      {super.key,
      required this.channelInfoView,
      required this.contentGridView});

  final Widget channelInfoView;
  final Widget contentGridView;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 채널 정보 섹션
            channelInfoView,
            const Gap(24),
            // 콘텐츠 목록 섹션
            contentGridView,

            const Gap(24),
          ],
        ),
      ),
    );
  }
}
