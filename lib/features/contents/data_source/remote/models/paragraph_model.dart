import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/modules/converter/duration_converter.dart';
import 'package:techtalk/features/contents/repositories/entities/paragraph_entity.dart';

part 'paragraph_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ParagraphModel {
  ParagraphModel({
    required this.title,
    required this.contents,
    this.timestamp,
  });

  final String title;

  final List<String> contents;

  @DurationConverter()
  final Duration? timestamp;

  ParagraphEntity toEntity() {
    return ParagraphEntity(
      title: title,
      contents: contents,
      timestamp: timestamp,
    );
  }

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory ParagraphModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ParagraphModel.fromJson(snapshot.data()!);

  /// JSON에서 모델로 변환
  factory ParagraphModel.fromJson(Map<String, dynamic> json) =>
      _$ParagraphModelFromJson(json);

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() => _$ParagraphModelToJson(this);
}
