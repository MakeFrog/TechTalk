import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_answer_model.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview_new/question/data/remote/interview_question_remote_data_source.dart';
import 'package:techtalk/features/interview_new/topic/data/models/enum/interview_topic.enum.dart';

final class InterviewRemoteDataSourceImpl
    implements InterviewQuestionRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _topicDoc(String topicId) =>
      _firestore.collection(FirestoreCollection.interview.name).doc(topicId);

  CollectionReference<Map<String, dynamic>> _questionCollection(
    String topicId,
  ) =>
      _topicDoc(topicId)
          .collection(FirestoreCollection.interviewQuestions.name);

  DocumentReference<Map<String, dynamic>> _questionDoc(
    String topicId,
    String questionId,
  ) =>
      _questionCollection(topicId).doc(questionId);

  @override
  Future<List<InterviewQuestionModel>> getQuestions(String topicId) async {
    final snapshot = await _questionCollection(topicId).get();

    if (snapshot.docs.isEmpty) {
      throw NoInterviewQuestionException(
        InterviewTopicData.getTopicById(topicId).text,
      );
    }

    return [
      ...snapshot.docs.map(InterviewQuestionModel.fromFirestore),
    ];
  }

  @override
  Future<DateTime> getUpdateDate(String topicId) async {
    final snapshot = await _topicDoc(topicId).get();
    try {
      final updateDate = snapshot.get('update_date') as Timestamp;

      return updateDate.toDate();
    } catch (e) {
      throw NoInterviewTopicException(
        InterviewTopicData.getTopicById(topicId).text,
      );
    }
  }

  @override
  Future<InterviewQuestionModel> getQuestion(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await _questionDoc(topicId, questionId).get();

    if (!snapshot.exists) {
      throw NoInterviewQuestionException(
        InterviewTopicData.getTopicById(topicId).text,
      );
    }

    return InterviewQuestionModel.fromFirestore(snapshot);
  }

  @override
  Future<List<InterviewAnswerModel>> getAnswers(
    String topicId,
    String questionId,
  ) {
    // TODO: implement getAnswersOfQuestion
    throw UnimplementedError();
  }
}
