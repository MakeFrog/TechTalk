import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
  @override
  Future<List<TopicModel>> getTopics() async {
    final topicModels = await FirestoreTopicsRef.collection().get();

    return [
      ...topicModels.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<List<TopicQnaModel>> getQnas(String topicId) async {
    final snapshot = await FirestoreTopicQuestionsRef.collection(topicId).get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<TopicQnaModel> getQna(
    String topicId,
    String questionId,
  ) async {
    final snapshot =
        await FirestoreTopicQuestionsRef.doc(topicId, questionId).get();

    if (!snapshot.exists) {
      throw Exception('문답이 존재하지 않습니다');
    }

    return snapshot.data()!;
  }

  @override
  Future<void> updateWrongAnswer(
      {required WrongAnswerModel wrongAnswer, required String topicId}) async {
    await FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        final docRef = FirestoreTopicWrongAnswerRef.subCollectionDoc(
            topicId, wrongAnswer.id, FirebaseAuth.instance.currentUser!.uid);

        final prevDoc = await docRef.get();

        if (prevDoc.exists) {
          transaction.update(docRef, {
            FirestoreTopicWrongAnswerRef.wrongAnswerCountField:
                FieldValue.increment(1),
            FirestoreTopicWrongAnswerRef.updatedAtField:
                FieldValue.serverTimestamp(),
            FirestoreTopicWrongAnswerRef.userAnswerField:
                wrongAnswer.userAnswer,
          });
        } else {
          transaction.set(
            docRef,
            wrongAnswer,
          );
        }
      },
    );
  }

  @override
  Future<List<WrongAnswerModel>> getWrongAnswers(String topicId) async {
    final collectionRef = FirestoreTopicWrongAnswerRef.subCollection(
            topicId, FirebaseAuth.instance.currentUser!.uid)
        .orderBy('updated_at', descending: true);

    final snapshot = await collectionRef.get();

    final result = snapshot.docs.map((e) => e.data()).toList();

    return result;
  }

  @override
  Future<void> deleteUserWrongAnswers() async {
    for (var topic in StoredTopics.list) {
      final ref = FirestoreTopicWrongAnswerRef.subCollection(
        topic.id,
        FirebaseAuth.instance.currentUser!.uid,
      );

      final docRef = await ref.get();

      for (var doc in docRef.docs) {
        await ref.doc(doc.id).delete();
      }
    }
  }
}

// Future<void> removeQuestions(String topicId) async {
//   final ref = FirestoreTopicQuestionsRef.collection(topicId);
//
//   // Get all documents in the subcollection
//   QuerySnapshot querySnapshot = await ref.get();
//
//   // Delete each document in the subcollection
//   for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
//     await ref.doc(documentSnapshot.id).delete();
//   }
// }
//
// @override
// Future<void> addQuestions(String topicId) async {
//   // final ref = FirestoreTopicQuestionsRef.collection(topicId);
//   // JSON 파일 읽기
//   String jsonString =
//   await rootBundle.loadString('assets/json/$topicId.json');
//
//   List<dynamic> jsonData = json.decode(jsonString);
//
//   for (var e in jsonData) {
//     final ref = FirebaseFirestore.instance
//         .collection('Topics')
//         .doc(topicId)
//         .collection('Questions')
//         .doc(e['id']);
//
//     await ref.set(e);
//   }
// }
