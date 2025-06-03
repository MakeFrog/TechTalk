import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

part 'portfolio_entity.g.dart';

@JsonSerializable()
final class PortfolioEntity extends DocumentBaseEntity {
  PortfolioEntity({
    type = DocumentType.portfolio,
    super.path,
    super.title,
    super.uploadAt,
    super.extractedText,
  });

  factory PortfolioEntity.fromJson(Map<String, dynamic> json) =>
      _$PortfolioEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioEntityToJson(this);

  PortfolioEntity copyWith({
    String? path,
    String? title,
    String? uploadAt,
    String? extractedText,
  }) {
    return PortfolioEntity(
      path: path ?? this.path,
      title: title ?? this.title,
      uploadAt: uploadAt ?? this.uploadAt,
      extractedText: extractedText ?? this.extractedText,
    );
  }
}
