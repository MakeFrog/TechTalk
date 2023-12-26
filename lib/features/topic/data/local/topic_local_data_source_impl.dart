import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/data/models/topic_ref.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicLocalDataSourceImpl implements TopicLocalDataSource {
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
    final snapshot = await FirestoreTopicQuestionRef.collection(topicId)
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
    final snapshot = await FirestoreTopicQuestionRef.doc(topicId, questionId)
        .get(const GetOptions(source: Source.cache));

    if (!snapshot.exists) {
      return null;
    }

    return snapshot.data();
  }
}
