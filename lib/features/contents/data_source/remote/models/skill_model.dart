// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
//
// part 'skill_model.g.dart';
//
// @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
// class SkillModel {
//   SkillModel({
//     required this.id,
//     required this.name,
//   });
//
//   final String id;
//
//   final String name;
//
//   /// 엔티티로 변환
//   SkillEntity toEntity() {
//     return SkillEntity(
//       id: id,
//       name: name,
//       imagePath: '',
//       category: null,
//     );
//   }
//
//   /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
//   factory SkillModel.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) =>
//       SkillModel.fromJson(snapshot.data()!);
//
//   /// JSON에서 모델로 변환
//   factory SkillModel.fromJson(Map<String, dynamic> json) =>
//       _$SkillModelFromJson(json);
//
//   /// 모델을 JSON으로 변환
//   Map<String, dynamic> toJson() => _$SkillModelToJson(this);
// }
