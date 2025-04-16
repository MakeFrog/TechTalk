import 'package:hive/hive.dart';

part 'resume_box.g.dart';

@HiveType(typeId: 5)
class ResumeBox extends HiveObject {
  @HiveField(0, defaultValue: null)
  final String? resumePath;

  @HiveField(1, defaultValue: null)
  final String? resumeTitle;

  @HiveField(2, defaultValue: null)
  final String? resumeUploadAt;

  @HiveField(3, defaultValue: null)
  final String? resumeExtractedText;

  ResumeBox({
    this.resumePath,
    this.resumeTitle,
    this.resumeUploadAt,
    this.resumeExtractedText,
  });

  ResumeBox copyWith({
    String? resumePath,
    String? resumeTitle,
    String? resumeUploadAt,
    String? resumeExtractedText,
  }) {
    return ResumeBox(
      resumePath: resumePath ?? this.resumePath,
      resumeTitle: resumeTitle ?? this.resumeTitle,
      resumeUploadAt: resumeUploadAt ?? this.resumeUploadAt,
      resumeExtractedText: resumeExtractedText ?? this.resumeExtractedText,
    );
  }
}
