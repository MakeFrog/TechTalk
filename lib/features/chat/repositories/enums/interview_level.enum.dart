import 'package:techtalk/core/constants/assets.dart';

///
/// 인터뷰 레벨
///
enum InterviewLevel {
  beginner(
      label: '하', titleLabel: '시니어', illustPath: Assets.iconsAdvancedIllust),
  intermediate(
      label: '중',
      titleLabel: '주니어',
      illustPath: Assets.iconsIntermediateIllust),
  advanced(
      label: '상', titleLabel: '초심자', illustPath: Assets.iconsBeginnerIllust);

  final String titleLabel;
  final String label;
  final String illustPath;

  const InterviewLevel({
    required this.label,
    required this.titleLabel,
    required this.illustPath,
  });
}
