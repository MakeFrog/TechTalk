import 'dart:io';

import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox extends HiveObject {
  @HiveField(0)
  final bool hasPracticalInterviewRecord;

  @HiveField(1)
  final bool isReviewRequestAvailable;

  /// 인터뷰를 시도한적 있는지 여부
  @HiveField(2, defaultValue: true)
  final bool hasEnteredFirstInterview;

  /// 이력서
  /// 인터뷰를 시도한적 있는지 여부
  @HiveField(3)
  final File? resume;

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
    required this.resume,
  });

  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
    File? resume,
  }) {
    return UserBox(
        hasPracticalInterviewRecord:
            hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
        isReviewRequestAvailable:
            isReviewRequestAvailable ?? this.isReviewRequestAvailable,
        hasEnteredFirstInterview:
            hasEnteredFirstInterview ?? this.isReviewRequestAvailable,
        resume: resume ?? this.resume);
  }

  factory UserBox.defaultValue() {
    return UserBox(
      hasPracticalInterviewRecord: false,
      isReviewRequestAvailable: true,
      hasEnteredFirstInterview: false,
      resume: null,
    );
  }
}
