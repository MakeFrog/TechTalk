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
    super.extractedText,
  });

  factory ResumeEntity.fromJson(Map<String, dynamic> json) =>
      _$ResumeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeEntityToJson(this);

  ResumeEntity copyWith({
    String? path,
    String? title,
    String? uploadAt,
    String? extractedText,
  }) {
    return ResumeEntity(
      path: path ?? this.path,
      title: title ?? this.title,
      uploadAt: uploadAt ?? this.uploadAt,
      extractedText: extractedText ?? this.extractedText,
    );
  }
}
