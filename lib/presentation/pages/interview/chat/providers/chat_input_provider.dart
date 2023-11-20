import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_input_provider.g.dart';

@riverpod
class ChatInput extends _$ChatInput {
  @override
  String build() {
    return '';
  }

  void update(String message) {
    state = message;
  }

  void reset() {
    state = '';
  }
}
