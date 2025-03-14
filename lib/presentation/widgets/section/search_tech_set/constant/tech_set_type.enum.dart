enum TechSetType {
  jobGroup('직군'),
  skill('스킬');

  final String label;

  const TechSetType(this.label);

  bool get isSkill => TechSetType.skill == this;
}
