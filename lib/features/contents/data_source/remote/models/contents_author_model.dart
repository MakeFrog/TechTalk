import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';

part 'contents_author_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ContentsAuthorModel {
  ContentsAuthorModel({
    required this.id,
    required this.name,
    required this.profileImgUrl,
  });

  final String id;
  final String name;
  final String? profileImgUrl;

  /// 엔티티로 변환

  ContentsAuthorEntity toEntity() {
    return ContentsAuthorEntity(
      id: id,
      name: name,
      profileImgUrl: profileImgUrl,
    );
  }

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory ContentsAuthorModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ContentsAuthorModel.fromJson(snapshot.data()!);

  /// JSON에서 모델로 변환
  factory ContentsAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$ContentsAuthorModelFromJson(json);

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() => _$ContentsAuthorModelToJson(this);
}
