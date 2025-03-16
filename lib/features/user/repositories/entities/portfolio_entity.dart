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
  });

  factory PortfolioEntity.fromJson(Map<String, dynamic> json) =>
      _$PortfolioEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioEntityToJson(this);
}
