import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/pages/youtube/main/provider/selected_filter_category_provider.dart';

import 'provider/youtube_content_pagination_provider.dart';

mixin class YoutubeContentMainState {
  ///
  /// 페이지네이션 컨트롤러
  ///
  PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
      YoutubeContentOverviewEntity> pagingController(WidgetRef ref) {
    final selectedCategory =
        ref.watch(youtubeContentCategoryProvider).selectedCategory;

    final pagingController =
        ref.watch(youtubeContentPaginationProvider(category: selectedCategory));
    return pagingController;
  }

  ///
  /// 페이지 컨트롤러
  ///
  PageController pageController(WidgetRef ref) =>
      ref.watch(youtubeContentCategoryProvider.select((p) => p.pageController));

  ///
  /// 콘텐츠 카테고리 리스트
  ///
  List<YoutubeContentCategory> totalCategories(WidgetRef ref) => ref
      .watch(youtubeContentCategoryProvider.select((p) => p.totalCategories));

  ///
  /// 선택된 카테고리
  ///
  YoutubeContentCategory selectedCategory(WidgetRef ref) => ref
      .watch(youtubeContentCategoryProvider.select((p) => p.selectedCategory));
}
