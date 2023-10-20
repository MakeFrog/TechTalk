import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/topic_interview/topic_select/topic_select_page.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';

part 'router.g.dart';
part 'routes/main_route.dart';
part 'routes/sign_in_route.dart';
part 'routes/sign_up_route.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      initialLocation: !ref.read(isUserAuthorizedProvider)
          ? SignInRoute.name
          : MainRoute.name,
      routes: $appRoutes,
    );
