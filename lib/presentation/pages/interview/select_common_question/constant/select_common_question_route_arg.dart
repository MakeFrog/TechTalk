import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

final class SelectCommonQuestionRouteArg {
  final List<TechSetEntity> techSets;

  const SelectCommonQuestionRouteArg({
    required this.techSets,
  });
}
