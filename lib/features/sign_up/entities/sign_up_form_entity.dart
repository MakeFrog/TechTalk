import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';

class SignUpFormEntity {
  final String? nickname;
  final String? nicknameValidation;
  final List<JobGroupEntity> jobGroupList;
  final List<TechSkillEntity> techSkillList;

  bool get isPassNickname => nickname != null && nicknameValidation == null;
  bool get isSelectedAtLeastOneJobGroup => jobGroupList.isNotEmpty;
  bool get isSelectedAtLeastOneTechSkill => techSkillList.isNotEmpty;

//<editor-fold desc="Data Methods">
  SignUpFormEntity({
    this.nickname,
    this.nicknameValidation,
    List<JobGroupEntity>? jobGroupList,
    List<TechSkillEntity>? techSkillList,
  })  : jobGroupList = jobGroupList ?? [],
        techSkillList = techSkillList ?? [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignUpFormEntity &&
          runtimeType == other.runtimeType &&
          nickname == other.nickname &&
          nicknameValidation == other.nicknameValidation &&
          jobGroupList == other.jobGroupList &&
          techSkillList == other.techSkillList);

  @override
  int get hashCode =>
      nickname.hashCode ^
      nicknameValidation.hashCode ^
      jobGroupList.hashCode ^
      techSkillList.hashCode;

  @override
  String toString() {
    return 'SignUpFormEntity{' +
        ' nickname: $nickname,' +
        ' nicknameValidation: $nicknameValidation,' +
        ' jobGroupList: $jobGroupList,' +
        ' techSkillList: $techSkillList,' +
        '}';
  }

  SignUpFormEntity copyWith({
    String? nickname,
    String? nicknameValidation,
    List<JobGroupEntity>? jobGroupList,
    List<TechSkillEntity>? techSkillList,
  }) {
    return SignUpFormEntity(
      nickname: nickname ?? this.nickname,
      nicknameValidation: nicknameValidation ?? this.nicknameValidation,
      jobGroupList: jobGroupList ?? this.jobGroupList,
      techSkillList: techSkillList ?? this.techSkillList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': this.nickname,
      'nicknameValidation': this.nicknameValidation,
      'jobGroupList': this.jobGroupList,
      'techSkillList': this.techSkillList,
    };
  }

  factory SignUpFormEntity.fromMap(Map<String, dynamic> map) {
    return SignUpFormEntity(
      nickname: map['nickname'] as String,
      nicknameValidation: map['nicknameValidation'] as String,
      jobGroupList: map['jobGroupList'] as List<JobGroupEntity>,
      techSkillList: map['techSkillList'] as List<TechSkillEntity>,
    );
  }

//</editor-fold>
}
