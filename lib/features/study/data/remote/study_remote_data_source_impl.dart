import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/study/data/models/study_question_list_model.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyRemoteDataSourceImpl implements StudyRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<StudyQuestionListModel> getQuestionList(String techId) async {
    final docRef =
        _firestore.collection(FirestoreCollection.study.name).doc(techId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      throw CustomException(
        code: 'code',
        message: '학습 질문 없음',
      );
    }

    return StudyQuestionListModel.fromFirestore(docSnapshot);
  }

  @override
  Future<DateTime> getLastQuestionsUpdateDate(String techId) async {
    final docRef =
        _firestore.collection(FirestoreCollection.study.name).doc(techId);
    final docSnapshot = await docRef.get();
    final updateDate = docSnapshot.get('update_date') as Timestamp;

    return updateDate.toDate();
  }
}
