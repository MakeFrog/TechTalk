import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/study/data/models/study_question_list_model.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyLocalDataSourceImpl implements StudyLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<StudyQuestionListModel?> getQuestionList(String techId) async {
    final docRef =
        _firestore.collection(FirestoreCollection.study.name).doc(techId);
    final docSnapshot = await docRef.get(
      const GetOptions(
        source: Source.cache,
      ),
    );

    if (!docSnapshot.exists) {
      return null;
    }

    return StudyQuestionListModel.fromFirestore(docSnapshot);
  }
}
