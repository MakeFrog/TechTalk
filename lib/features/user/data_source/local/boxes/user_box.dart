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

  @HiveField(2, defaultValue: true)
  final bool hasEnteredFirstInterview;

  @HiveField(3, defaultValue: null)
  final ResumeBox? resume;

  @HiveField(4, defaultValue: null)
  final PortfolioBox? portfolio;

  UserBox({
    required this.hasPracticalInterviewRecord,
    required this.isReviewRequestAvailable,
    required this.hasEnteredFirstInterview,
    this.resume,
    this.portfolio,
  });

  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
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
      resume: resume ?? this.resume,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  factory UserBox.defaultValue() {
    return UserBox(
      hasPracticalInterviewRecord: false,
      isReviewRequestAvailable: true,
      hasEnteredFirstInterview: false,
    );
  }

  UserBox deleteResume() {
    return UserBox(
      resume: null,
      portfolio: portfolio, // 기존 포트폴리오 필드 그대로
      hasPracticalInterviewRecord: hasPracticalInterviewRecord,
      isReviewRequestAvailable: isReviewRequestAvailable,
      hasEnteredFirstInterview: hasEnteredFirstInterview,
    );
  }

  UserBox deletePortfolio() {
    return UserBox(
      resume: resume, // 기존 이력서 필드 그대로
      portfolio: null,
      hasPracticalInterviewRecord: hasPracticalInterviewRecord,
      isReviewRequestAvailable: isReviewRequestAvailable,
      hasEnteredFirstInterview: hasEnteredFirstInterview,
    );
  }
}
