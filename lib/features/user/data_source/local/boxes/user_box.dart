import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox extends HiveObject {
  @HiveField(0)
  final bool hasPracticalInterviewRecord;

  @HiveField(1)
  final bool isReviewRequestAvailable;

  @HiveField(2, defaultValue: true)
  final bool hasEnteredFirstInterview;

  @HiveField(3, defaultValue: null)
  final String? resumePdfPath;

  @HiveField(4, defaultValue: null)
  final String? resumePdfTitle;

  @HiveField(5, defaultValue: null)
  final String? resumePdfDate;

  @HiveField(6, defaultValue: null)
  final String? portfolioPdfPath;

  @HiveField(7, defaultValue: null)
  final String? portfolioPdfTitle;

  @HiveField(8, defaultValue: null)
  final String? portfolioPdfDate;

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
    this.resumePdfPath,
    this.resumePdfTitle,
    this.resumePdfDate,
    this.portfolioPdfPath,
    this.portfolioPdfTitle,
    this.portfolioPdfDate,
  });

  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
    String? resumePdfPath,
    String? resumePdfTitle,
    String? resumePdfDate,
    String? portfolioPdfPath,
    String? portfolioPdfTitle,
    String? portfolioPdfDate,
  }) {
    return UserBox(
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      isReviewRequestAvailable:
          isReviewRequestAvailable ?? this.isReviewRequestAvailable,
      hasEnteredFirstInterview:
          hasEnteredFirstInterview ?? this.hasEnteredFirstInterview,
      resumePdfPath: resumePdfPath ?? this.resumePdfPath,
      resumePdfTitle: resumePdfTitle ?? this.resumePdfTitle,
      resumePdfDate: resumePdfDate ?? this.resumePdfDate,
      portfolioPdfPath: portfolioPdfPath ?? this.portfolioPdfPath,
      portfolioPdfTitle: portfolioPdfTitle ?? this.portfolioPdfTitle,
      portfolioPdfDate: portfolioPdfDate ?? this.portfolioPdfDate,
    );
  }

  factory UserBox.defaultValue() {
    return UserBox(
      hasPracticalInterviewRecord: false,
      isReviewRequestAvailable: true,
      hasEnteredFirstInterview: false,
    );
  }
}
