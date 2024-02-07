import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_list_box.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topics_ref.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicLocalDataSourceImpl implements TopicLocalDataSource {
  TopicLocalDataSourceImpl(this.box);

  final Box<QnaListBox> box;

  QnaListBox? get localQnas => box.values.firstOrNull;

  @override
  Future<List<TopicCategoryModel>> getTopicCategories() async {
    final topicCategoriesJsonString =
        await rootBundle.loadString(Assets.jsonTopicCategoriesData);
    final topicCategoriesJson = jsonDecode(topicCategoriesJsonString) as List;

    return topicCategoriesJson
        .cast<Map<String, dynamic>>()
        .map(TopicCategoryModel.fromJson)
        .toList();
  }

  @override
  Future<List<TopicQnaModel>?> getQnas(
    String topicId,
  ) async {
    final snapshot = await FirestoreTopicQuestionsRef.collection(topicId)
        .get(const GetOptions(source: Source.cache));

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<TopicQnaModel?> getQna(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await FirestoreTopicQuestionsRef.doc(topicId, questionId)
        .get(const GetOptions(source: Source.cache));

    return snapshot.data();
  }

  @override
  QnaListBox? loadQnas(String topicId) {
    print('========= [아지랑이] : ${box.get(topicId)} 로드됨');
    return box.get(topicId);
  }

  @override
  Future<void> storeQnas(
      {required String topicId, required List<TopicQnaModel> qnas}) async {
    print('========= [아지랑이] : ${topicId} 저장됨');
    await box.put(topicId, QnaListBox.fromModel(qnas));
  }
}
