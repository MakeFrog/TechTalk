import 'dart:math';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:techtalk/features/study/data/models/study_question_list_model.dart';
import 'package:techtalk/features/study/data/models/study_question_model.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyRemoteDataSourceFake implements StudyRemoteDataSource {
  @override
  Future<StudyQuestionListModel> getQuestionList(String techId) async {
    await Future.delayed(2.seconds);

    return StudyQuestionListModel(
      updateDate: DateTime.now(),
      questions: List.generate(
        50,
        (index) => StudyQuestionModel(
          question: 'Self와 self의 차이는 무엇인가요?',
          answers: [
            ...List.generate(
              Random().nextInt(3) + 1,
              (_) =>
                  'Self는 프로토콜에서 사용되면 프로토콜을 채택하는 타입을 의미하고, 클래스, 구조체, 열거형에서 사용되면 실제 선언에 사용된 타입을 의미합니다.',
            )
          ],
        ),
      ),
    );
  }

  @override
  Future<DateTime> getLastQuestionsUpdateDate(String techId) {
    // TODO: implement getLastQuestionsUpdateDate
    throw UnimplementedError();
  }
}
