import 'package:go_router/go_router.dart';

abstract class Bindings {
  void dependencies();

  void unRegister();
}

class GoRouteWithBinding extends GoRoute {
  GoRouteWithBinding({
    required this.newBuilder,
    required this.binding,
    required String path,
    List<RouteBase> routes = const <RouteBase>[],
    String? prevPath,
  }) : super(
          path: path,
          builder: (context, state) {
            final goRouter = GoRouter.of(context).routeInformationProvider;
            if (prevPath == goRouter.value.location) {
              binding.dependencies();
            }
            return newBuilder(context, state);
          },
          routes: routes,
        );

  final Bindings binding;
  final GoRouterWidgetBuilder newBuilder;
}
