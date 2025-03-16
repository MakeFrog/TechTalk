import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

part 'resume_entity.g.dart';

@JsonSerializable()
final class ResumeEntity extends DocumentBaseEntity {
  ResumeEntity({
    type = DocumentType.resume,
    super.path,
    super.title,
    super.uploadAt,
  });

  factory ResumeEntity.fromJson(Map<String, dynamic> json) =>
      _$ResumeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeEntityToJson(this);
}
