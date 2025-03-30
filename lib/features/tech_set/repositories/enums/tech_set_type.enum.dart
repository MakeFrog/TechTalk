import 'package:easy_localization/easy_localization.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';

enum TechSetType {
  jobGroup(LocaleKeys.techSet_type_jobGroup),
  skill(LocaleKeys.techSet_type_skill);

  final String labelKey;

  const TechSetType(this.labelKey);

  String get label => tr(labelKey);

  bool get isSkill => TechSetType.skill == this;
}
