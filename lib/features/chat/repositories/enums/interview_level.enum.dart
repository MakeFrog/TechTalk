import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';

///
/// 인터뷰 레벨
///
enum InterviewLevel {
  advanced(
    labelKey: LocaleKeys.interview_interviewLevel_advanced_label,
    titleKey: LocaleKeys.interview_interviewLevel_advanced_title,
    descriptionKey: LocaleKeys.interview_interviewLevel_advanced_description,
    illustPath: Assets.iconsBeginnerIllust,
  ),
  intermediate(
    labelKey: LocaleKeys.interview_interviewLevel_intermediate_label,
    titleKey: LocaleKeys.interview_interviewLevel_intermediate_title,
    descriptionKey:
        LocaleKeys.interview_interviewLevel_intermediate_description,
    illustPath: Assets.iconsIntermediateIllust,
  ),
  beginner(
    labelKey: LocaleKeys.interview_interviewLevel_beginner_label,
    titleKey: LocaleKeys.interview_interviewLevel_beginner_title,
    descriptionKey: LocaleKeys.interview_interviewLevel_beginner_description,
    illustPath: Assets.iconsAdvancedIllust,
  );

  final String titleKey;
  final String labelKey;
  final String descriptionKey;
  final String illustPath;

  const InterviewLevel({
    required this.labelKey,
    required this.titleKey,
    required this.descriptionKey,
    required this.illustPath,
  });
}
