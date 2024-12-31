import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum YoutubeContentAnalyzedType {
  @JsonValue('isValid')
  isValid,
  @JsonValue('notTech')
  notTech,
  @JsonValue('lackOfContent')
  lackOfContent,
  undefined;

  static YoutubeContentAnalyzedType getById(String id) {
    return YoutubeContentAnalyzedType.values.firstWhere(
      (e) {
        final safeElement = e.name.toLowerCase();
        final safeId = e.name.toLowerCase();

        return safeElement == safeId;
      },
      orElse: () => YoutubeContentAnalyzedType.undefined,
    );
  }

  bool get isValidContent => this == YoutubeContentAnalyzedType.isValid;

  bool get isInvalid => !(this == YoutubeContentAnalyzedType.isValid);
}
