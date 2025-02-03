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

  @HiveField(3)
  final ResumeBox? resume;

  @HiveField(4)
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
    bool nullResume = false,
    PortfolioBox? portfolio,
    bool nullPortfolio = false,
  }) {
    return UserBox(
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      isReviewRequestAvailable:
          isReviewRequestAvailable ?? this.isReviewRequestAvailable,
      hasEnteredFirstInterview:
          hasEnteredFirstInterview ?? this.hasEnteredFirstInterview,
      resume: nullResume ? null : (resume ?? this.resume),
      portfolio: nullPortfolio ? null : (portfolio ?? this.portfolio),
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
