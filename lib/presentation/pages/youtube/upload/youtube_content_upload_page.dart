import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_content_upload_event.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_content_upload_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/item/youtube_content_item_view.dart';

part 'widgets/page_views/analyzing_content_view.p.dart';
part 'widgets/page_views/analyzing_view.p.dart';
part 'widgets/page_views/confirm_content_view.p.dart';
part 'widgets/page_views/url_input_view.p.dart';

class YoutubeContentUploadPage extends BasePage
    with YoutubeContentUploadState, YoutubeContentUploadEvent {
  const YoutubeContentUploadPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController(ref),
      children: const [
        _UrlInputView(),
        _AnalyzingView(),
        _ConfirmContentView(),
        _AnalyzingContentView(),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      onBackBtnTapped: () {
        onBackBtnTapped(ref);
      },
    );
  }

  @override
  bool get setBottomSafeArea => false;
}
