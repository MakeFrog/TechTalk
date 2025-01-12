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

  @HiveField(3)
  final String resumePdfPath;

  @HiveField(4)
  final String resumePdfTitle;

  @HiveField(5)
  final String resumePdfDate;

  @HiveField(6)
  final String portfolioPdfPath;

  @HiveField(7)
  final String portfolioPdfTitle;

  @HiveField(8)
  final String portfolioPdfDate;

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
    required this.resumePdfPath,
    required this.resumePdfTitle,
    required this.resumePdfDate,
    required this.portfolioPdfPath,
    required this.portfolioPdfTitle,
    required this.portfolioPdfDate,
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
      resumePdfPath: '',
      resumePdfTitle: '',
      resumePdfDate: '',
      portfolioPdfPath: '',
      portfolioPdfTitle: '',
      portfolioPdfDate: '',
    );
  }
}
