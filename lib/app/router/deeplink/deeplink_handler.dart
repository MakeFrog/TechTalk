/* 딥링크 URL 형식
<scheme>://<host>/<path>?<query>
techtalk://notification/detail?id=123
*/

/* 딥링크 URL 형식
<scheme>://<host>/<path>?<query>
techtalk://notification/detail?id=123
*/

import 'dart:developer';
import 'dart:io';

import 'package:techtalk/app/router/deeplink/deep_link_define.enum.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/app.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:url_launcher/url_launcher.dart';

part 'deeplink_handler_intent.p.dart';

final class DeepLinkHandler {
  Future<void> handleDeepLink(String url) async {
    Uri uri = Uri.parse(url);

    final targetScheme = uri.scheme;
    if (targetScheme != DeeplinkScheme.techtalk.name) {
      log('정의되지 않은 스키마 입니다. scheme: ${uri.scheme}');
      return;
    }

    final targetHost = DeeplinkHost.getByHostName(uri.host);

    switch (targetHost) {
      case DeeplinkHost.landing ||
            DeeplinkHost.prefixHomeLanding ||
            DeeplinkHost.prefixYoutubeLanding:
        await _handleInAppNavigation(uri);
        break;
      case DeeplinkHost.externalLanding:
        _openExternalPage(uri);
        break;
      case DeeplinkHost.execute:
        _executeInternalMethod(uri);
        break;
      case DeeplinkHost.newFeature:
        _showVersionUpdateAlert(uri);
        break;

      default:
        log('정의 안된 호스트 입니다. host: ${uri.host}');
    }
  }

  static final DeepLinkHandler _instance = DeepLinkHandler._internal();

  factory DeepLinkHandler() => _instance;

  DeepLinkHandler._internal();
}
