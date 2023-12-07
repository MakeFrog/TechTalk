import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'study_questions_provider.g.dart';

@riverpod
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<InterviewQuestionEntity>> build(String topicId) async {
    final result = await getInterviewQuestionsUseCase(topicId);

    return result.fold(
      onSuccess: (value) => value,
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );

        throw e;
      },
    );
  }
}
