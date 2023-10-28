import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';

part 'sign_up_form_entity.freezed.dart';
part 'sign_up_form_entity.g.dart';

@freezed
class SignUpFormEntity with _$SignUpFormEntity {
  const factory SignUpFormEntity({
    String? nickname,
    String? nicknameValidation,
    @Default([]) List<JobGroupModel> jobGroupList,
    @Default([]) List<TechSkillEntity> techSkillList,
  }) = _SignUpFormEntity;

  const SignUpFormEntity._();

  bool get isPassNickname => nickname != null && nicknameValidation == null;
  bool get isSelectedAtLeastOneJobGroup => jobGroupList.isNotEmpty;
  bool get isSelectedAtLeastOneTechSkill => techSkillList.isNotEmpty;

  factory SignUpFormEntity.fromJson(Map<String, dynamic> json) =>
      _$SignUpFormEntityFromJson(json);
}
