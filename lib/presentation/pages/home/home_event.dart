import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';

abstract interface class _HomeEvent {
  void onTapNewTopicInterview(BuildContext context);
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapNewTopicInterview(BuildContext context) {
    const HomeTopicSelectRoute().push(context);
  }
}
