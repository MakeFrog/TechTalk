import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension RiverpodRefExt on Ref {
  /// [notifier]의 변화를 감지하고 변화가 발생하면 [notifyListeners]를 실행한다.
  /// onDispose 될 때 자동으로 [notifier]를 dispose한다.
  T disposeAndListenChangeNotifier<T extends ChangeNotifier>(T notifier) {
    onDispose(notifier.dispose);
    notifier.addListener(notifyListeners);
    return notifier;
  }

  /// onDispose 될 때 자동으로 dipose되는 [notifier]를 생성한다.
  T autoDisposeChangeNotifier<T extends ChangeNotifier>(T notifier) {
    onDispose(notifier.dispose);

    return notifier;
  }

  /// Dio의 [CancelToken]을 사용해 onDispose 될 때 [CancelToken]을 사용한 Dio 요청을 취소한다.
  CancelToken createCancelToken() {
    final token = CancelToken();

    onDispose(token.cancel);

    return token;
  }

  /// [duration]의 딜레이를 가지는 디바운싱을 적용한다.
  ///
  /// [duration] 시간안에 dispose된다면 [execDebounce] 하위의 로직은 실행하지 않고 Exception을 throw한다.
  Future<void> execDebounce([Duration? duration]) async {
    // First, we handle debouncing.
    bool didDispose = false;

    onDispose(() => didDispose = true);

    // We delay the request by 500ms, to wait for the user to stop refreshing.
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 500));

    // If the provider was disposed during the delay, it means that the user
    // refreshed again. We throw an exception to cancel the request.
    // It is safe to use an exception here, as it will be caught by Riverpod.
    if (didDispose) {
      throw Exception('Cancelled');
    }
  }
}

extension RiverpodRefCacheExt on AutoDisposeRef {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}

extension AsyncValueX<T> on AsyncValue<T> {
  R whenFetchOrNull<R>({
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
    required R Function(T? data) data,
    required R Function(Object error, StackTrace stackTrace) error,
  }) {
    if (hasError && (!hasValue || !skipError)) {
      return error(this.error!, stackTrace!);
    }

    return data(valueOrNull);
  }
}
