import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qna_model.freezed.dart';
part 'qna_model.g.dart';

@freezed
class QnaModel with _$QnaModel {
  const factory QnaModel({
    required String id,
    required String question,
    required List<String> answers,
  }) = _QnaModel;

  factory QnaModel.fromJson(Map<String, dynamic> json) =>
      _$QnaModelFromJson(json);

  factory QnaModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      QnaModel.fromJson(snapshot.data() as Map<String, dynamic>);
}
