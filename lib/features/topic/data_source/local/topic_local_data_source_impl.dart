import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_box.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_list_box.dart';
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
  QnaListBox? loadQnas(String topicId) {
    return box.get(topicId);
  }

  @override
  QnaBox? loadSingleQna({required String topicId, required String qnaId}) {
    final qnas = box.get(topicId);
    if (qnas == null) return null;
    return qnas.items.firstWhereOrNull((e) => e.id == qnaId);
  }

  @override
  Future<void> storeQnas(
      {required String topicId, required List<TopicQnaModel> qnas}) async {
    await box.put(topicId, QnaListBox.fromModel(qnas));
  }
}
