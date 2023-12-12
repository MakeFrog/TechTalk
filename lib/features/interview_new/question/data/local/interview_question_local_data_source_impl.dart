import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/interview_new/question/data/local/interview_question_local_data_source.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_answer_model.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_question_model.dart';

class InterviewQuestionLocalDataSourceImpl
    implements InterviewQuestionLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  FutureOr<List<InterviewQuestionModel>?> getQuestions(
    String topicId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollection.interview.name)
          .doc(topicId)
          .collection(FirestoreCollection.interviewQuestions.name)
          .get(const GetOptions(source: Source.cache));

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return [
        ...snapshot.docs.map(
          InterviewQuestionModel.fromFirestore,
        ),
      ];
    } catch (e) {
      return null;
    }
  }

  @override
  FutureOr<DateTime?> getUpdateDate(String topicId) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollection.interview.name)
          .doc(topicId)
          .get(const GetOptions(source: Source.cache));
      final updateDate = snapshot.get('update_date') as Timestamp?;

      return updateDate?.toDate();
    } catch (e) {
      return null;
    }
  }

  @override
  FutureOr<List<InterviewAnswerModel>?> getAnswers(
    String topicId,
    String questionId,
  ) {
    // TODO: implement getAnswersOfQuestion
    throw UnimplementedError();
  }

  @override
  FutureOr<InterviewQuestionModel?> getQuestion(
    String topicId,
    String questionId,
  ) {
    // TODO: implement getQuestion
    throw UnimplementedError();
  }
}
