import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';

part 'youtube_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeQnaModel {
  const YoutubeQnaModel({
    required this.id,
    required this.question,
    required this.evaluationPoint,
  });

  final String id;
  final String question;
  final String? evaluationPoint;

  YoutubeQnaEntity toEntity() {
    return YoutubeQnaEntity(
      id: id,
      question: question,
      evaluationPoint: evaluationPoint,
    );
  }

  factory YoutubeQnaModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      YoutubeQnaModel.fromJson(snapshot.data()!);

  factory YoutubeQnaModel.fromJson(Map<String, dynamic> json) {
    return _$YoutubeQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$YoutubeQnaModelToJson(this);
}
