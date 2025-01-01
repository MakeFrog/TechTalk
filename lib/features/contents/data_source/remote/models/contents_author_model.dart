import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';

part 'contents_author_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ChannelModel {
  ChannelModel({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  final String id;
  final String name;
  final String? logoUrl;

  /// 엔티티로 변환

  ChannelEntity toEntity() {
    return ChannelEntity(
      id: id,
      name: name,
      logoUrl: logoUrl,
    );
  }

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory ChannelModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ChannelModel.fromJson(snapshot.data()!);

  /// JSON에서 모델로 변환
  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);

  factory ChannelModel.fromEntity(ChannelEntity entity) => ChannelModel(
        id: entity.id,
        name: entity.name,
        logoUrl: entity.logoUrl,
      );
}
