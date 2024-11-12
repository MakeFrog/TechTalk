import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/presentation/pages/contents/contents_detail_event.dart';
import 'package:techtalk/presentation/pages/contents/contents_detail_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/box/async_skeleton_widget_builder.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

/// 유튜브 컨텐츠 상세 페이지
class ContentsDetailPage extends BasePage with ContentsDetailEvent, ContentsDetailState {
  const ContentsDetailPage({super.key, required this.overview});

  final ContentsOverviewEntity overview;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AsyncSkeletonWidgetBuilder(
          asyncValue: youtubeVideoDataAsync(ref, overview.contentsId),
          skeletonBuilder: (p0) => SizedBox(
            height: 210,
            width: double.infinity,
            child: Image.network(
              overview.thumbnailImgUrl,
              fit: BoxFit.cover,
            ),
          ),
          dataBuilder: (context, data) => SizedBox(
            height: 210,
            width: double.infinity,
            // TODO: 이미지 캐싱 기능 구현
            child: Image.network(
              data.thumnailSet.highResUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Wrap(
            runSpacing: 5,
            children: [
              AsyncSkeletonWidgetBuilder(
                asyncValue: youtubeVideoDataAsync(ref, overview.contentsId),
                skeletonBuilder: (p0) => Text(
                  overview.contentsTitle,
                  style: AppTextStyle.headline3,
                ),
                dataBuilder: (context, data) => Text(
                  data.title,
                  style: AppTextStyle.headline3,
                ),
              ),
              AsyncSkeletonWidgetBuilder(
                asyncValue: youtubeVideoDataAsync(ref, overview.contentsId),
                skeletonBuilder: (_) => const SkeletonBox(
                  height: 20,
                ),
                dataBuilder: (context, data) => Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(data.likeCountStr),
                      ],
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text('조회수 ${data.viewCountStr}'),
                  ],
                ),
              ),
              AsyncSkeletonWidgetBuilder(
                asyncValue: youtubeVideoDataAsync(ref, overview.contentsId),
                skeletonBuilder: (p0) => const SkeletonBox(
                  height: 20,
                ),
                dataBuilder: (context, data) => Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data.channelInfo.logoUrl),
                      radius: 15,
                    ),
                    Text(
                      data.channelInfo.title,
                    ),
                    Text(
                      (data.channelInfo.subscribersCount ?? '').toString(),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: overview.relatedSkills
                    .map(
                      (skill) => Chip(label: Text(skill.name)),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get canPop => false;

  @override
  Color? get screenBackgroundColor => AppColor.of.white;

  @override
  Color? get unSafeAreaColor => AppColor.of.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => AppBar(
        leading: const AppBackButton(),
        titleSpacing: 0,
      );
}
