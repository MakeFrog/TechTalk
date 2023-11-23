import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_focus_node_provider.g.dart';

@riverpod
class ChatFocusNode extends _$ChatFocusNode {
  @override
  Raw<FocusNode> build() {
    final focusNode = FocusNode();

    ref.onDispose(() {
      focusNode.removeListener(focusNode.dispose);
    });

    return focusNode;
  }
}
