import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SkillModel {
  SkillModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }

  factory SkillModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!;

    return SkillModel(
      id: snapshot.id,
      name: json['name'],
    );
  }

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return _$SkillModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SkillModelToJson(this);
}
