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

  //
  UserBox copyWith({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
    ResumeBox? resume,
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
      resume: resume ?? this.resume,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  // TODO: copywith는 제대로 동작을 하지 않으니 resume, portfolio 업데이트 로직을 여기에다가 따로 구성하기 (윤수)
  UserBox updateResume({
    bool? hasPracticalInterviewRecord,
    bool? isReviewRequestAvailable,
    bool? hasEnteredFirstInterview,
    PortfolioBox? portfolio,
    ResumeBox? resume,
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
}
