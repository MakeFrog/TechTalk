import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension RiverpodRefExt on Ref {
  // We can move the previous logic to a Ref extension.
  // This enables reusing the logic between providers
  T disposeAndListenChangeNotifier<T extends ChangeNotifier>(T notifier) {
    onDispose(notifier.dispose);
    notifier.addListener(notifyListeners);
    // We return the notifier to ease the usage a bit
    return notifier;
  }

  CancelToken createCancelToken() {
    final token = CancelToken();

    onDispose(token.cancel);

    return token;
  }

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

extension RiverpodWidgetRefExt on WidgetRef {
  ///
  /// provider 리스트를 즉시 dispose(invalidate)
  ///
  void disposeProviders(List<ProviderOrFamily> providers) {
    for (final provider in providers) {
      invalidate(provider);
    }
  }
}
