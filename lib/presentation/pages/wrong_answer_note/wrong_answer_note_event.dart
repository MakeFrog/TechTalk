import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/review_note_detail_page_controller.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_wrong_answer_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_blur_provider.dart';

mixin class WrongAnswerNoteEvent {
  void onTapTopicChip(WidgetRef ref, TopicEntity topic) {
    ref.read(selectedWrongAnswerTopicProvider.notifier).updateTopic(topic);
  }

  ///
  /// 오답 질문 Listile이 클릭 되었을 때
  ///
  void routeToDetail(int page) {
    WrongAnswerRoute(page).push(rootNavigatorKey.currentContext!);
  }

  ///
  /// 단일 면접 주제 개수 선택 페이지로 이동
  ///
  void routeToSingleSubjectQuestionCount(WidgetRef ref) {
    final selectedTopic = ref.read(selectedWrongAnswerTopicProvider);

    QuestionCountSelectPageRoute(
      InterviewType.singleTopic,
      $extra: [selectedTopic!],
    ).push(ref.context);
  }

  ///
  /// 주제 선택 페이지로 이동
  ///
  void routeToTopicSelection(WidgetRef ref, {required InterviewType type}) {
    InterviewTopicSelectRoute(type).push(ref.context);
  }

  ///
  /// 답안 가리기 스위치 버튼이 클릭 되었을 때
  ///
  void onHideAnswerSwitchTapped(WidgetRef ref) {
    ref.read(wrongAnswerBlurProvider.notifier).toggle();
  }

  ///
  /// 다음 페이지로 이동
  ///
  void jumpToNextPage(WidgetRef ref) => ref
      .read(reviewNoteDetailPageControllerProvider.notifier)
      .jumpToNextPage();

  ///
  /// 이전 페이지로 이동
  ///
  void jumpToPreviousPage(WidgetRef ref) => ref
      .read(reviewNoteDetailPageControllerProvider.notifier)
      .jumpToPreviousPage();
}
