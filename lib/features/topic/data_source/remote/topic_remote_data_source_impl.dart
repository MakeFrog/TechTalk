import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topics_ref.dart';
import 'package:techtalk/features/topic/data_source/remote/models/wrong_answer_model.dart';
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
      throw Exception();
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
        topicId, FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await collectionRef.get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  ///임시
  Future<void> removeQuestions(String topicId) async {
    final ref = FirestoreTopicQuestionsRef.collection(topicId);

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await ref.get();

    // Delete each document in the subcollection
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await ref.doc(documentSnapshot.id).delete();
    }
  }

  @override
  Future<void> addQuestions(String topicId) async {
    // final ref = FirestoreTopicQuestionsRef.collection(topicId);
    // JSON 파일 읽기
    String jsonString =
        await rootBundle.loadString('assets/topics/$topicId.json');

    List<dynamic> jsonData = json.decode(jsonString);

    for (var e in jsonData) {
      final ref = FirebaseFirestore.instance
          .collection('Topics')
          .doc(topicId)
          .collection('Questions')
          .doc(e['id']);

      await ref.set(e);
    }
  }
}
