import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/core/services/slack_notification_service.dart' as noti;
import 'package:techtalk/presentation/pages/blog/blog_detail/providers/blog_detail_roug_arg_provider.dart';
import 'package:techtalk/presentation/pages/blog/blog_origin_page.dart/blog_origin_page.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/bottom_sheet_intent.dart';

mixin class BlogDetailEvent {
  ///
  /// 블로그 버튼 클릭 시 호출되는 함수
  ///
  Future<void> onGoToBlogBtnTapped(WidgetRef ref) async {
    final blogItem = ref.read(blogDetailRouteArgProvider).item;
    unawaited(
      noti.SlackNotificationService.sendNotification(
        type: SlackNotificationType.event,
        message: '블로그 상세 페이지에 진입했어요. 제목 : ${blogItem.title}',
      ),
    );

    await BottomSheetIntent.showScrollableModalSheet(
      ref.context,
      scrollableSheet: BlogOriginPage(
        blogUrl: blogItem.linkUrl,
      ),
    );
  }
}
