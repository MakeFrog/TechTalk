import 'package:techtalk/core/constants/assets.dart';

///
/// 인터뷰 레벨
///
enum InterviewLevel {
  advanced(
    label: '상',
    titleLabel: '시니어',
    description: '심층적인 기술 역량을 확인하는 질문',
    illustPath: Assets.iconsBeginnerIllust,
  ),
  intermediate(
    label: '중',
    titleLabel: '주니어',
    description: '핵심 기술·실전 감각을 확인하는 실무형 개발자 면접 질문',
    illustPath: Assets.iconsIntermediateIllust,
  ),
  beginner(
    label: '하',
    titleLabel: '신입',
    description: '기초 문법·로직 중심의 가벼운 질문',
    illustPath: Assets.iconsAdvancedIllust,
  );

  final String titleLabel;
  final String label;
  final String description;
  final String illustPath;

  const InterviewLevel({
    required this.label,
    required this.titleLabel,
    required this.description,
    required this.illustPath,
  });
}
