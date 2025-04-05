import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/provider/selected_interview_topic_provider.dart';
import 'package:techtalk/presentation/providers/topic/selectable_common_qnas_provider.dart';

import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';

import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/provider/select_common_question_route_arg_provider.dart';

mixin class SelectCommonQuestionState {
  ///
  /// 선택된 주제 (테크셋)
  ///
  TopicEntity selectedTopic(WidgetRef ref) {
    final arg = ref.read(selectCommonQuestionRouteArgProvider);
    return ref.watch(selectedInterviewTopicProvider(arg.topics.first));
  }

  ///
  /// 선택된 주제 (테크셋) 목록
  ///
  List<TopicEntity> topics(WidgetRef ref) {
    return ref.read(selectCommonQuestionRouteArgProvider).topics;
  }

  ///
  /// 선택 가능한 질문 목록
  ///
  AsyncValue<List<SelectableQnaEntity<CommonQnaEntity>>> selectableQnas(
      WidgetRef ref,
      {required TopicEntity topic}) {
    return ref.watch(selectableCommonQnasProvider(topic.id));
  }

  ///
  /// 북마크된 질문이 모두 선택되었는지 확인
  ///
  bool isAllBookmarkedQnasSelected(WidgetRef ref,
      {required TopicEntity topic}) {
    final qnas = selectableQnas(ref, topic: topic).valueOrNull;
    if (qnas == null) return false;

    final bookmarkedQnas = qnas.where((qna) => ref
        .read(selectableCommonQnasProvider(topic.id).notifier)
        .bookMarkedQnaIds
        .contains(qna.qna.id));

    // 북마크된 질문이 없으면 false 반환 (버튼 활성화)
    if (bookmarkedQnas.isEmpty) return false;

    // 북마크된 질문이 모두 선택된 경우 true 반환 (버튼 비활성화)
    return bookmarkedQnas.every((qna) => qna.isSelected);
  }

  ///
  /// 선택된 모든 QnA 리스트
  ///
  List<SelectableQnaEntity> selectedQnas(WidgetRef ref) {
    final List<SelectableQnaEntity> selectedQnas = [];
    for (final topic in topics(ref)) {
      final qnas = ref.watch(selectableCommonQnasProvider(topic.id));
      qnas.when(
        data: (qnas) {
          selectedQnas.addAll(qnas.where((qna) => qna.isSelected));
        },
        loading: () {},
        error: (_, __) {},
      );
    }
    return selectedQnas;
  }
}
