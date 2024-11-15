import 'package:techtalk/core/constants/assets.dart';

enum InterviewResult {
  pass(Assets.iconsPassResult),
  failed(Assets.iconsFailResult);

  final String illustration;

  const InterviewResult(this.illustration);

  bool get isPassed => this == InterviewResult.pass;
}
