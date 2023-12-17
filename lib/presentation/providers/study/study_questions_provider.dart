import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/entities/qna_entity.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';

part 'study_questions_provider.g.dart';

@Riverpod(
  dependencies: [
    selectedStudyTopicId,
  ],
)
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<QnaEntity>> build() async {
    final topicId = ref.watch(selectedStudyTopicIdProvider);

    final response = await interviewRepository.getQnaList.call(topicId);

    return response.fold(
      onSuccess: (qnaList) {
        return qnaList;
      },
      onFailure: (e) {
        log(e.toString());
        throw e;
      },
    );
  }

  void updateTest() {
    state = AsyncData([...state.requireValue, ...state.requireValue]);
  }
}
