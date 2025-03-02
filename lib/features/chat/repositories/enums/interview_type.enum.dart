import 'package:techtalk/core/constants/assets.dart';

enum InterviewType {
  commonSingleTopic(
    logoPath: Assets.iconsCommonInterviewLogo,
    interviewEndIllust: Assets.imagesInductionPractical,
  ),
  commonPracticalTopic(
    logoPath: Assets.iconsCommonInterviewLogo,
    interviewEndIllust: Assets.imagesInductionSingle,
  ),
  ai(
    logoPath: Assets.iconsAiInterviewLogo,
    interviewEndIllust: Assets.imagesInductionResume,
  ),
  resume(
    logoPath: Assets.iconsResumeInterviewLogo,
    interviewEndIllust: Assets.imagesInductionResume,
  ),
  youtube(
    logoPath: Assets.iconsYoutubeInterviewLogo,
    interviewEndIllust: Assets.imagesInductionResume,
  );

  /// 대표 로고
  final String logoPath;

  /// 인터뷰가 종료된 이후 보여지는 일러스트
  final String interviewEndIllust;

  bool get isSingleTopic => this == InterviewType.commonSingleTopic;

  bool get isPractical => this == InterviewType.commonPracticalTopic;

  bool get isCommonQuestionType =>
      this == InterviewType.commonSingleTopic ||
      this == InterviewType.commonPracticalTopic;

  bool get isYoutube => this == InterviewType.youtube;

  bool get isResume => this == InterviewType.resume;

  const InterviewType({
    required this.logoPath,
    required this.interviewEndIllust,
  });

  R typedBranch<R>({
    required R Function(InterviewType type) common,
    required R Function(InterviewType type) resume,
    required R Function(InterviewType type) youtube,
  }) {
    switch (this) {
      case InterviewType.commonSingleTopic ||
            InterviewType.commonPracticalTopic:
        return common(this);
      case InterviewType.resume:
        return resume(this);
      case InterviewType.youtube:
        return youtube(this);
      default:
        throw Exception('잘못된 타입입니다 : $this');
    }
  }

  R branch<R>({
    required R Function(InterviewType type) singleTopic,
    required R Function(InterviewType type) practical,
    required R Function(InterviewType type) resume,
    required R Function(InterviewType type) youtube,
  }) {
    switch (this) {
      case InterviewType.commonSingleTopic:
        return singleTopic(this);
      case InterviewType.commonPracticalTopic:
        return practical(this);
      case InterviewType.resume:
        return resume(this);
      case InterviewType.youtube:
        return youtube(this);
      default:
        throw Exception('잘못된 타입입니다 : $this');
    }
  }
}
