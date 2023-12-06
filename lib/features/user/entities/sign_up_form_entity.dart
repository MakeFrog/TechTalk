import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/skill/skill.dart';

class SignUpFormEntity {
  final String? nickname;
  final String? nicknameValidation;
  final List<JobGroupEntity> jobGroups;
  final List<SkillEntity> skills;

  bool get isPassNickname =>
      nickname != null && nickname!.isNotEmpty && nicknameValidation == null;
  bool get isSelectedAtLeastOneJobGroup => jobGroups.isNotEmpty;

//<editor-fold desc="Data Methods">
  SignUpFormEntity({
    this.nickname = '',
    this.nicknameValidation = '',
    List<JobGroupEntity>? jobGroupList,
    List<SkillEntity>? techSkillList,
  })  : jobGroups = jobGroupList ?? [],
        skills = techSkillList ?? [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignUpFormEntity &&
          runtimeType == other.runtimeType &&
          nickname == other.nickname &&
          nicknameValidation == other.nicknameValidation &&
          jobGroups == other.jobGroups &&
          skills == other.skills);

  @override
  int get hashCode =>
      nickname.hashCode ^
      nicknameValidation.hashCode ^
      jobGroups.hashCode ^
      skills.hashCode;

  @override
  String toString() {
    return 'SignUpFormEntity{' +
        ' nickname: $nickname,' +
        ' nicknameValidation: $nicknameValidation,' +
        ' jobGroupList: $jobGroups,' +
        ' techSkillList: $skills,' +
        '}';
  }

  SignUpFormEntity copyWith({
    String? nickname,
    String? nicknameValidation,
    List<JobGroupEntity>? jobGroupList,
    List<SkillEntity>? techSkillList,
  }) {
    return SignUpFormEntity(
      nickname: nickname ?? this.nickname,
      nicknameValidation: nicknameValidation ?? this.nicknameValidation,
      jobGroupList: jobGroupList ?? this.jobGroups,
      techSkillList: techSkillList ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': this.nickname,
      'nicknameValidation': this.nicknameValidation,
      'jobGroupList': this.jobGroups,
      'techSkillList': this.skills,
    };
  }

  factory SignUpFormEntity.fromMap(Map<String, dynamic> map) {
    return SignUpFormEntity(
      nickname: map['nickname'] as String,
      nicknameValidation: map['nicknameValidation'] as String,
      jobGroupList: map['jobGroupList'] as List<JobGroupEntity>,
      techSkillList: map['techSkillList'] as List<SkillEntity>,
    );
  }

//</editor-fold>
}
