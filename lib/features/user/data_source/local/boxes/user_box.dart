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

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
  });

  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
  }) {
    return UserBox(
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      isReviewRequestAvailable:
          isReviewRequestAvailable ?? this.isReviewRequestAvailable,
      hasEnteredFirstInterview:
          hasEnteredFirstInterview ?? this.isReviewRequestAvailable,
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
