import 'package:hive/hive.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_box.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topic_qna_model.dart';

part 'qna_list_box.g.dart';

@HiveType(typeId: 2)
class QnaListBox extends HiveObject {
  @HiveField(0)
  final DateTime updatedAt;

  @HiveField(1)
  final List<QnaBox> items;

  QnaListBox({required this.updatedAt, required this.items});

  factory QnaListBox.fromModel(List<TopicQnaModel> entity) => QnaListBox(
        updatedAt: DateTime.now(),
        items: entity.map(QnaBox.fromModel).toList(),
      );

  QnaListBox addItemFromModel(TopicQnaModel entity) => QnaListBox(
        updatedAt: updatedAt,
        items: [...items, QnaBox.fromModel(entity)],
      );
}
