import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Bindings {
  void dependencies();
}

class GoRouteWithBinding extends GoRoute {
  GoRouteWithBinding(
      {required this.newBuilder,
      required this.binding,
      required String path})
      : super(
          path: path,
          builder: (context, state) {
            binding.dependencies();
            return newBuilder(context, state);
          },
        );

  final Bindings binding;
  final GoRouterWidgetBuilder newBuilder;
}
