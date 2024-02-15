import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wrong_answer_note_scroll_controller.g.dart';

@riverpod
class WrongAnswerNoteScrollController
    extends _$WrongAnswerNoteScrollController {
  static double animatedOffset = 20;

  @override
  Raw<ScrollController> build() {
    return ScrollController();
  }
}
