import 'package:hive/hive.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skills_result_model.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_box.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topic_qna_model.dart';

part 'tech_set_box.g.dart';

@HiveType(typeId: 4)
class TechSetBox extends HiveObject {
  /// 테크 스킬
  @HiveField(0)
  final SkillsResultModel skill;

  TechSetBox({required this.skill});

// factory QnaListBox.fromModel(List<TopicQnaModel> entity) => QnaListBox(
//   updatedAt: DateTime.now(),
//   items: entity.map(QnaBox.fromModel).toList(),
// );
//
// QnaListBox addItemFromModel(TopicQnaModel entity) => QnaListBox(
//   updatedAt: updatedAt,
//   items: [...items, QnaBox.fromModel(entity)],
// );
}
