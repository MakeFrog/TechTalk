import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';

enum SkillCategory {
  data,
  mobile,
  frontend,
  backend,
  testing,
  database,
  language,
  cs,
  pattern,
  none;

  static SkillCategory fromKey(String key) {
    final target = SkillCategory.values.firstWhereOrNull((e) => e.name == key);
    return target ?? SkillCategory.none;
  }
}
