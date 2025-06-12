import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/presentation/pages/blog/blog_detail/blog_detail_page.dart';
import 'package:techtalk/presentation/pages/blog/blog_detail/constant/blog_detail_route_arg.dart';
import 'package:techtalk/presentation/pages/blog/blog_main/provider/blog_category_provider.dart';
import 'package:techtalk/presentation/pages/blog/blog_origin_page.dart/blog_origin_page.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/bottom_sheet_intent.dart';
import 'package:techtalk/presentation/widgets/common/constant/content_filter_category.dart';
import 'package:techtalk/core/services/slack_notification_service.dart' as noti;

mixin class BlogMainEvent {
  ///
  /// 컨텐츠 카테고리 chip이 클릭 되었을 때
  ///
  void onCategoryChipTapped(WidgetRef ref,
      {required ContentFilterCategory targetCategory, required int index}) {
    ref
        .read(blogContentCategoryProvider.notifier)
        .toggleCategorySelection(targetCategory);

    final pageController =
        ref.read(blogContentCategoryProvider.select((p) => p.pageController));
    pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 1),
      curve: Curves.bounceIn,
    );
  }

  void onBlogUploadBtnTapped(BuildContext context) {
    // 추후 구현
  }

  Future<void> fetchNextPage() async {
    // 추후 구현ㅊ
  }

  ///
  /// 블로그 컨텐츠 클릭 시 호출되는 함수
  ///
  Future<void> onBlogContentTapped(
      BuildContext context, BlogShellEntity item) async {
    unawaited(
      noti.SlackNotificationService.sendNotification(
        type: SlackNotificationType.event,
        message: '블로그 상세 페이지에 진입했어요. 제목 : ${item.title}',
      ),
    );
    await BlogDetailRoute(BlogDetailRouteArg(item: item)).push(context);
    // await BottomSheetIntent.showScrollableModalSheet(
    //   context,
    //   scrollableSheet: BlogOriginPage(
    //     blogUrl: 'https://techtalk-xim-yas-projects.vercel.app/blog/${item.id}',
    //   ),
    // );
  }
}
