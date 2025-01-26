import 'package:techtalk/core/constants/assets.dart';

enum InterviewType {
  commonSingleTopic(Assets.imagesInductionPractical),
  commonPracticalTopic(Assets.imagesInductionSingle),
  resume(Assets.imagesInductionResume),
  youtube(Assets.imagesInductionResume);

  bool get isSingleTopic => this == InterviewType.commonSingleTopic;

  bool get isPractical => this == InterviewType.commonPracticalTopic;

  bool get isCommonQuestionType =>
      this == InterviewType.commonSingleTopic ||
      this == InterviewType.commonPracticalTopic;

  bool get isResume => this == InterviewType.resume;

  const InterviewType(this.illusrationPath);

  final String illusrationPath;

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
