import 'package:hive/hive.dart';

part 'tech_set_box.g.dart';

@HiveType(typeId: 4)
class TechSetBox extends HiveObject {
  /// 테크 스킬
  @HiveField(0)
  final Map<String, Map<String, List<Map<String, String>>>>? skillJson;

  TechSetBox({required this.skillJson});

  TechSetBox copyWith({
    Map<String, Map<String, List<Map<String, String>>>>? skillJson,
  }) {
    return TechSetBox(
      skillJson: skillJson ?? this.skillJson,
    );
  }
}
