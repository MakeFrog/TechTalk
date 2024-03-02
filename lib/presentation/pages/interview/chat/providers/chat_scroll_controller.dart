import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_scroll_controller.g.dart';

@riverpod
Raw<ScrollController> chatScrollController(ChatScrollControllerRef ref) {
  return ScrollController();
}
