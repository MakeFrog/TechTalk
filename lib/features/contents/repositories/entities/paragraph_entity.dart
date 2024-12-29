import 'package:techtalk/features/contents/data_source/remote/models/paragraph_model.dart';

/// 한 문단을 구성하는 엔티티
class ParagraphEntity {
  /// 문단 제목
  final String title;

  /// 문단 내용
  final List<String> contents;

  /// 해당 문단의 시작 시간
  final Duration? timestamp;

  ParagraphEntity({
    required this.title,
    required this.contents,
    this.timestamp,
  });

  ParagraphModel toModel() => ParagraphModel(
        title: title,
        contents: contents,
        timestamp: timestamp,
      );
}
