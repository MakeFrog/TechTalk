import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract class FirestoreTopicsRef {
  static const String name = 'Topics';

  static CollectionReference<TopicModel> collection() =>
      FirebaseFirestore.instance.collection(name).withConverter(
            fromFirestore: TopicModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<TopicModel> doc(String id) =>
      FirebaseFirestore.instance.collection(name).doc(id).withConverter(
            fromFirestore: TopicModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreTopicQuestionsRef {
  static const String name = 'Questions';

  static CollectionReference<TopicQnaModel> collection(String topicId) =>
      FirestoreTopicsRef.doc(topicId).collection(name).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<TopicQnaModel> doc(
    String topicId,
    String id,
  ) =>
      FirestoreTopicsRef.doc(topicId).collection(name).doc(id).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreTopicWrongAnswerRef {
  static const String name = 'WrongAnswers';
  static const String subCollectionName = 'Records';
  static const String wrongAnswerCountField = 'wrong_answer_count';
  static const String updatedAtField = 'updated_at';
  static const String userAnswerField = 'user_answer';

  static CollectionReference<WrongAnswerModel> collection(String topicId) =>
      FirestoreTopicsRef.doc(topicId).collection(name).withConverter(
            fromFirestore: WrongAnswerModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static CollectionReference<WrongAnswerModel> subCollection(
    String topicId,
    String userId,
  ) =>
      FirestoreTopicsRef.doc(topicId)
          .collection(name)
          .doc(userId)
          .collection(subCollectionName)
          .withConverter(
            fromFirestore: WrongAnswerModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<WrongAnswerModel> subCollectionDoc(
    String topicId,
    String qnaId,
    String userId,
  ) =>
      FirestoreTopicsRef.doc(topicId)
          .collection(name)
          .doc(userId)
          .collection(subCollectionName)
          .doc(qnaId)
          .withConverter(
            fromFirestore: WrongAnswerModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
