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

  static R branch<R>({
    required InterviewType targetType,
    required R Function(InterviewType type) singleTopic,
    required R Function(InterviewType type) practical,
    required R Function(InterviewType type) resume,
  }) {
    switch (targetType) {
      case InterviewType.singleTopic:
        return singleTopic(targetType);
      case InterviewType.practical:
        return practical(targetType);
      case InterviewType.resume:
        return resume(targetType);
      default:
        throw Exception('잘못된 타입입니다 : $targetType');
    }
  }
}
