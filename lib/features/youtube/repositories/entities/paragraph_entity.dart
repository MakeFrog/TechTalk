import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/modules/converter/string_to_duration_conveter.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/paragraph_model.dart';

part 'paragraph_entity.g.dart';

/// 한 문단을 구성하는 엔티티
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: false)
class ParagraphEntity {
  /// 문단 제목
  final String title;

  /// 문단 내용
  final List<String> contents;

  /// 해당 문단의 시작 시간
  @StringToDurationConveter()
  @JsonKey(name: 'offset')
  final Duration? timestamp;

  const ParagraphEntity({
    required this.title,
    required this.contents,
    this.timestamp,
  });

  ParagraphModel toModel() => ParagraphModel(
        title: title,
        contents: contents,
        timestamp: timestamp,
      );

  factory ParagraphEntity.fromJson(Map<String, dynamic> json) =>
      _$ParagraphEntityFromJson(json);
}
