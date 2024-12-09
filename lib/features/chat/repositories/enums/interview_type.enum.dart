import 'package:techtalk/core/constants/assets.dart';

enum InterviewType {
  singleTopic(Assets.imagesInductionPractical),
  practical(Assets.imagesInductionSingle),
  resume(Assets.imagesInductionResume);

  bool get isSingleTopic => this == InterviewType.singleTopic;
  bool get isPractical => this == InterviewType.practical;
  bool get isResume => this == InterviewType.resume;

  const InterviewType(this.illusrationPath);

  final String illusrationPath;

  R branch<R>({
    required R Function(InterviewType type) singleTopic,
    required R Function(InterviewType type) practical,
    required R Function(InterviewType type) resume,
  }) {
    switch (this) {
      case InterviewType.singleTopic:
        return singleTopic(this);
      case InterviewType.practical:
        return practical(this);
      case InterviewType.resume:
        return resume(this);
      default:
        throw Exception('잘못된 타입입니다 : $this');
    }
  }
}
