import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/webview/techtalk_web_view.dart';
import 'package:techtalk/presentation/pages/blog/blog_detail/blog_detail_event.dart';
import 'package:techtalk/presentation/pages/blog/blog_detail/constant/blog_detail_route_arg.dart';
import 'package:techtalk/presentation/pages/blog/blog_detail/providers/blog_detail_roug_arg_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/techtalk_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class BlogDetailPage extends BasePage with BlogDetailEvent {
  const BlogDetailPage({super.key, required this.arg});

  final BlogDetailRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      blogDetailRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return TechTalkWebView(
      url: 'https://techtalk-xi.vercel.app/blog/${arg.item.id}',
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: BounceTapper(
            onTap: () {
              onGoToBlogBtnTapped(ref);
            },
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                '블로그 보기',
                style: AppTextStyle.alert1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wrapWithSafeArea => false;

  @override
  bool get setBottomSafeArea => false;
}
