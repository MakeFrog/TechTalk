import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'youtube_link_input_controller_provider.g.dart';

@riverpod
class YoutubeLinkInputController extends _$YoutubeLinkInputController {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Raw<TextEditingController> build() {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);

    return controller;
  }
}
