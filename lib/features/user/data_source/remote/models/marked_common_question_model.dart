import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'marked_common_question_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MarkedCommonQuestionModel {
  const MarkedCommonQuestionModel({
    required this.ids,
  });

  final List<String> ids;

  factory MarkedCommonQuestionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return MarkedCommonQuestionModel.fromJson(snapshot.data()!);
  }

  factory MarkedCommonQuestionModel.fromJson(Map<String, dynamic> json) {
    return _$MarkedCommonQuestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MarkedCommonQuestionModelToJson(this);
}
