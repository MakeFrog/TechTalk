import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tech_skill_model.freezed.dart';
part 'tech_skill_model.g.dart';

@freezed
class TechSkillModel with _$TechSkillModel {
  const factory TechSkillModel({
    required String id,
    required String name,
  }) = _TechSkillModel;

  const TechSkillModel._();

  factory TechSkillModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!..['id'] = snapshot.id;

    return TechSkillModel(
      id: json['id'],
      name: json['name'],
    );
  }

  factory TechSkillModel.fromJson(Map<String, dynamic> json) =>
      _$TechSkillModelFromJson(json);
}
