import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/helper/riverpod_extension.dart';

part 'review_note_detail_page_controller.g.dart';

@riverpod
class ReviewNoteDetailPageController extends _$ReviewNoteDetailPageController {
  @override
  Raw<PageController> build() {
    return ref.autoDisposeChangeNotifier(
      PageController(
        initialPage: WrongAnswerRoute.arg,
      ),
    );
  }

  void jumpToPreviousPage() {
    state.previousPage(
      duration: 400.ms,
      curve: Curves.easeOutQuint,
    );
  }

  void jumpToNextPage() {
    state.nextPage(
      duration: 400.ms,
      curve: Curves.easeOutQuint,
    );
  }
}
