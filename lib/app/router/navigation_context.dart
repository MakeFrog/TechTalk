import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:techtalk/app/router/router.dart';

Future<BuildContext> get navigationContext async {
  BuildContext? context = rootNavigatorKey.currentContext;

  if (context != null) return context;

  Completer<BuildContext> waitNextFrame = Completer<BuildContext>();
  int retries = 0;
  int maxRetries = 30; // 재시도 횟수 제한
  Duration delay = const Duration(milliseconds: 16); // 재시도 간격

  void _checkContext(SchedulerBinding instance) {
    context = rootNavigatorKey.currentContext;
    if (context != null) {
      waitNextFrame.complete(context);
    } else if (retries < maxRetries) {
      retries++;
      instance.addPostFrameCallback((_) async {
        await Future.delayed(delay); // 지연 후 재시도
        _checkContext(instance);
      });
    } else {
      waitNextFrame.completeError('빌드 컨텍스트 찾지 못함');
    }
  }

  await waitNextFrame.future.catchError((onError) {
    log('빌드 컨텍스트 찾지 못함');
  });

  SchedulerBinding.instance.addPostFrameCallback((_) async {
    _checkContext(SchedulerBinding.instance);
  });

  return waitNextFrame.future;
}
