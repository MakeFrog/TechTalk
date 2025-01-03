import 'package:json_annotation/json_annotation.dart';

enum YoutubeContentAnalyzedType {
  isValid,
  notTech,
  lackOfContent,
  undefined;

  static YoutubeContentAnalyzedType getById(String id) {
    return YoutubeContentAnalyzedType.values.firstWhere(
      (e) {
        final safeElement = e.name.toLowerCase();
        final safeId = id.toLowerCase();

        return safeElement == safeId;
      },
      orElse: () => YoutubeContentAnalyzedType.undefined,
    );
  }

  bool get isValidContent => this == YoutubeContentAnalyzedType.isValid;

  bool get isInvalid => !(this == YoutubeContentAnalyzedType.isValid);
}
