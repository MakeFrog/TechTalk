import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interview_result_page_view_controller_provider.g.dart';

@riverpod
class InterviewResultPageViewController
    extends _$InterviewResultPageViewController {
  @override
  PageController build() {
    final controller = PageController(viewportFraction: 0.833);
    return controller;
  }
}
