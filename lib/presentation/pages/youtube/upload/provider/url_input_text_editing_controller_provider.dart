import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'url_input_text_editing_controller_provider.g.dart';

@riverpod
class UrlInputTextEditingController extends _$UrlInputTextEditingController {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Raw<TextEditingController> build() {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);

    return controller;
  }
}
