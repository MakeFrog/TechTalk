import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';

mixin SelectedCommonInterviewTypeEvent {
  ///
  /// 면접 주제 선택 페이지로 이동
  ///
  void routeToTopicSelectPage(BuildContext context,
      {required InterviewType type}) {
    InterviewTopicSelectRoute(type.name).push(context);
  }
}
