import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/wrong_answer_entity.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/review_note_detail_page_controller.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_wrong_answer_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_note_scroll_controller.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answers_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class WrongAnswerNoteState {
  ///
  /// 유저 정보에 기록된 면접 주제 목록
  ///
  List<TopicEntity> userTopicRecords(WidgetRef ref) =>
      ref.watch(userInfoProvider).requireValue!.targetedTopics;

  ///
  /// 선택된 면접 주제
  ///
  TopicEntity? selectedTopic(WidgetRef ref) =>
      ref.watch(selectedWrongAnswerTopicProvider);

  ///
  /// 오답 문제 목록
  ///
  AsyncValue<List<WrongAnswerEntity>> wrongAnswersAsync(WidgetRef ref) {
    final selectedTopicId = ref.watch(selectedWrongAnswerTopicProvider)?.id;
    if (selectedTopicId == null) return const AsyncData([]);
    return ref.watch(wrongAnswersProvider(selectedTopicId));
  }

  ///
  /// 스크롤 컨트롤러
  ///
  ScrollController scrollController(WidgetRef ref) =>
      ref.watch(wrongAnswerNoteScrollControllerProvider);

  ///
  /// 페이지 컨트롤러
  ///
  PageController pageController(WidgetRef ref) =>
      ref.watch(reviewNoteDetailPageControllerProvider);
}
