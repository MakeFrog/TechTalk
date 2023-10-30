import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_scroll_controller_provider.g.dart';

@riverpod
class ChatScrollController extends _$ChatScrollController {
  @override
  Raw<ScrollController> build() {
    final controller = ScrollController();

    ref.onDispose(() {
      controller.removeListener(controller.dispose);
    });

    return controller;
  }

  /// 스크롤 포지션을 제일 하단으로 지정
  void setScrollPositionToBottom() {
    state.animateTo(0,
        duration: const Duration(milliseconds: 1), curve: Curves.bounceIn);
  }
}
