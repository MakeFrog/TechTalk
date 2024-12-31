import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/contents/data_source/remote/models/paragraph_model.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';

part 'summary_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SummaryModel {
  SummaryModel({
    required this.mainTheme,
    required this.summaries,
  });

  /// 핵심주제
  final String mainTheme;

  /// 요약
  final List<ParagraphModel> summaries;

  /// 엔티티로 변환
  SummaryEntity toEntity() {
    return SummaryEntity(
      mainTheme: mainTheme,
      summaries: summaries.map((summary) => summary.toEntity()).toList(),
    );
  }

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory SummaryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      SummaryModel.fromJson(snapshot.data()!);

  /// JSON에서 모델로 변환
  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);
}
