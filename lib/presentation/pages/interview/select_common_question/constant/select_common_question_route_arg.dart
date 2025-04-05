import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

final class SelectCommonQuestionRouteArg {
  final List<TopicEntity> topics;

  const SelectCommonQuestionRouteArg({
    required this.topics,
  });
}
