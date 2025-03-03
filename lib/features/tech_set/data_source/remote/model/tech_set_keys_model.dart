import 'package:json_annotation/json_annotation.dart';

part 'tech_set_keys_model.g.dart';

@JsonSerializable()
class TechSetKeysModel {
  final String? skill;

  TechSetKeysModel({required this.skill});

  factory TechSetKeysModel.fromJson(Map<String, dynamic> json) =>
      _$TechSetKeysModelFromJson(json);
}
