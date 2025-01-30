import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox extends HiveObject {
  @HiveField(0)
  final bool hasPracticalInterviewRecord;

  @HiveField(1)
  final bool isReviewRequestAvailable;

  /// 인터뷰를 시도한적 있는지 여부
  @HiveField(2, defaultValue: false)
  final bool hasEnteredFirstInterview;

  /// 유튜브 학습 신기능이 처음 노출되었는지 여부
  @HiveField(3, defaultValue: false)
  final bool hasSeenNewYoutubeFeature;

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
    required this.hasSeenNewYoutubeFeature,
  });

  factory UserBox.defaultValue() {
    return UserBox(
      hasPracticalInterviewRecord: false,
      isReviewRequestAvailable: true,
      hasEnteredFirstInterview: false,
      hasSeenNewYoutubeFeature: false,
    );
  }

  @override
  String toString() {
    return 'UserBox{hasPracticalInterviewRecord: $hasPracticalInterviewRecord, isReviewRequestAvailable: $isReviewRequestAvailable, hasEnteredFirstInterview: $hasEnteredFirstInterview, hasSeenNewYoutubeFeature: $hasSeenNewYoutubeFeature}';
  }

  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
    bool? hasSeenNewYoutubeFeature,
  }) {
    return UserBox(
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      isReviewRequestAvailable:
          isReviewRequestAvailable ?? this.isReviewRequestAvailable,
      hasEnteredFirstInterview:
          hasEnteredFirstInterview ?? this.hasEnteredFirstInterview,
      hasSeenNewYoutubeFeature:
          hasSeenNewYoutubeFeature ?? this.hasSeenNewYoutubeFeature,
    );
  }
}
