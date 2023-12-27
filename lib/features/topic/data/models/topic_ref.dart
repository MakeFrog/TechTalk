import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract class FirestoreTopicCategoryRef {
  static const String name = 'TopicCategories';

  static CollectionReference<TopicCategoryModel> collection() =>
      FirebaseFirestore.instance.collection(name).withConverter(
            fromFirestore: TopicCategoryModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<TopicCategoryModel> doc(String id) =>
      FirebaseFirestore.instance.collection(name).doc(id).withConverter(
            fromFirestore: TopicCategoryModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreTopicRef {
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

abstract class FirestoreTopicQuestionRef {
  static const String name = 'Questions';

  static CollectionReference<TopicQnaModel> collection(String topicId) =>
      FirestoreTopicRef.doc(topicId).collection(name).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<TopicQnaModel> doc(
    String topicId,
    String id,
  ) =>
      FirestoreTopicRef.doc(topicId).collection(name).doc(id).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
