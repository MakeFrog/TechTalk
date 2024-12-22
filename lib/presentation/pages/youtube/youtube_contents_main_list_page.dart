import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/presentation/pages/youtube/youtube_contents_main_event.dart';
import 'package:techtalk/presentation/pages/youtube/youtube_contents_overviews_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class YoutubeContentsMainListPage extends BasePage
    with YoutubeContentsMainListEvent {
  const YoutubeContentsMainListPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final pagingController = ref.watch(youtubeContentsOverviewsProvider);

    return PagedListView<DocumentSnapshot<YoutubeContentsOverviewModel>?,
        YoutubeContentOverviewEntity>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<YoutubeContentOverviewEntity>(
        itemBuilder: (context, item, index) => ListTile(
          leading: Image.network(
            item.thumbnailImgUrl,
            width: 100,
            height: 56,
            fit: BoxFit.cover,
          ),
          title: Text(item.contentsTitle),
          subtitle: Text('Author: ${item.channel.name}'),
          trailing: Text(
            '${item.videoDuration.inMinutes}m ${item.videoDuration.inSeconds % 60}s',
          ),
          onTap: () {
            routeToDetailPage(context, overview: item);
          },
        ),
        firstPageProgressIndicatorBuilder: (context) =>
            Center(child: CircularProgressIndicator()),
        newPageProgressIndicatorBuilder: (context) =>
            Center(child: CircularProgressIndicator()),
        firstPageErrorIndicatorBuilder: (context) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('데이터 로딩 중 오류가 발생했습니다.'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => pagingController.refresh(),
                child: Text('다시 시도'),
              ),
            ],
          ),
        ),
        newPageErrorIndicatorBuilder: (context) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('추가 데이터 로딩 중 오류가 발생했습니다.'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => pagingController.retryLastFailedRequest(),
                child: Text('다시 시도'),
              ),
            ],
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) =>
            Center(child: Text('데이터가 없습니다.')),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      AppBar(
        title: Text('유튜브 컨텐츠 리스트'),
      );
}
