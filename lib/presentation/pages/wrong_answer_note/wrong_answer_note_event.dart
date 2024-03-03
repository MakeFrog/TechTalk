import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/review_note_detail_page_controller.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_wrong_answer_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_blur_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class WrongAnswerNoteEvent {
  ///
  /// 오답노트 면접 주제 chip이 클릭 되었을 때
  ///
  void onTapTopicChip(WidgetRef ref, TopicEntity topic) {
    ref.read(selectedWrongAnswerTopicProvider.notifier).updateTopic(topic);
  }

  ///
  /// 오답 질문 Listile이 클릭 되었을 때
  ///
  void routeToDetail(WidgetRef ref, {required int page}) {
    WrongAnswerRoute(page).push(rootNavigatorKey.currentContext!);
    FirebaseAnalytics.instance.logEvent(
      name: 'Go to Wrong Answer Detail',
      parameters: {
        'user_id': ref.read(userInfoProvider).requireValue?.uid,
        'user_name': ref.read(userInfoProvider).requireValue?.nickname,
        'topic': ref.read(selectedWrongAnswerTopicProvider)?.text,
      },
    );
  }

  ///
  /// 단일 면접 주제 개수 선택 페이지로 이동
  ///
  void routeToSingleSubjectQuestionCount(WidgetRef ref) {
    final selectedTopic = ref.read(selectedWrongAnswerTopicProvider);
    const type = InterviewType.singleTopic;

    final route = QuestionCountSelectPageRoute(type, selectedTopic!.id);

    route.updateArg(type: type, topics: [selectedTopic]);

    route.push(ref.context);
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
