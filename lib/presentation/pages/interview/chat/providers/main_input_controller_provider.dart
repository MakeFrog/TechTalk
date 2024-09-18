import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_input_controller_provider.g.dart';

///
///
///
@riverpod
class MainInputController extends _$MainInputController {
  @override
  Raw<TextEditingController> build() {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);
    return TextEditingController();
  }

  void updateInput(String text) {
    state.text = text;
  }

  void addInputToExisting(String text) {
    state.text = state.text + text;
  }
}
