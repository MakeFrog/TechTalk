import 'package:hive/hive.dart';
import 'package:techtalk/features/user/data_source/local/boxes/portfolio_box.dart';
import 'package:techtalk/features/user/data_source/local/boxes/resume_box.dart';

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

  @HiveField(4, defaultValue: null)
  final ResumeBox? resume;

  @HiveField(5, defaultValue: null)
  final PortfolioBox? portfolio;

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
    required this.hasSeenNewYoutubeFeature,
    this.resume,
    this.portfolio,
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
    ResumeBox? resume,
    PortfolioBox? portfolio,
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
      resume: resume ?? this.resume,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  UserBox deleteResume() {
    return UserBox(
      resume: null,
      portfolio: portfolio, // 기존 포트폴리오 필드 그대로
      hasPracticalInterviewRecord: hasPracticalInterviewRecord,
      isReviewRequestAvailable: isReviewRequestAvailable,
      hasEnteredFirstInterview: hasEnteredFirstInterview,
      hasSeenNewYoutubeFeature: hasSeenNewYoutubeFeature,
    );
  }

  UserBox deletePortfolio() {
    return UserBox(
      resume: resume, // 기존 이력서 필드 그대로
      portfolio: null,
      hasPracticalInterviewRecord: hasPracticalInterviewRecord,
      isReviewRequestAvailable: isReviewRequestAvailable,
      hasEnteredFirstInterview: hasEnteredFirstInterview,
      hasSeenNewYoutubeFeature: hasSeenNewYoutubeFeature,
    );
  }
}
