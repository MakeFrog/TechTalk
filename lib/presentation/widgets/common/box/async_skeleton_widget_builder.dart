import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'skeleton_box.dart';

/// 비동기 동안 skeleton 위젯을 자연스럽게 띄워주는 위젯
class AsyncSkeletonWidgetBuilder<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(BuildContext, T) dataBuilder;
  final Widget Function(BuildContext)? skeletonBuilder;
  final Widget Function(BuildContext, Object, StackTrace)? errorBuilder;

  const AsyncSkeletonWidgetBuilder({
    Key? key,
    required this.asyncValue,
    required this.dataBuilder,
    this.skeletonBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: asyncValue.when(
        data: (data) => dataBuilder(context, data),
        loading: () => skeletonBuilder?.call(context) ?? _defaultSkeleton(),
        error: (error, stack) =>
            errorBuilder?.call(context, error, stack) ??
            _defaultError(context, error),
      ),
    );
  }

  Widget _defaultSkeleton() {
    // 기본 스켈레톤 UI 예시 (단일 SkeletonBox)
    return const SkeletonBox(
      height: 20,
    );
  }

  Widget _defaultError(BuildContext context, Object error) {
    return const SkeletonBox(
      height: 20,
    );
  }
}
