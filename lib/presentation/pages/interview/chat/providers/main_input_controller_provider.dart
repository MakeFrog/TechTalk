import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_input_controller_provider.g.dart';

///
///
///
@riverpod
class MainInputController extends _$MainInputController {
  // ignore: avoid_public_notifier_properties
  late FocusNode focusNode;

  @override
  Raw<TextEditingController> build() {
    final controller = TextEditingController();
    focusNode = FocusNode();
    ref.onDispose(() {
      controller.dispose();
      focusNode.dispose();
    });
    return TextEditingController();
  }

  void updateInput(String text) {
    state.text = text;
  }

  String addInputToExisting(String text) {
    state.text = state.text + text;
    return state.text;
  }
}
