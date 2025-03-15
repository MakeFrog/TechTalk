import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/provider/selected_tech_sets_provider.dart';

mixin class SearchTechSetState {
  ///
  /// 선택된 직군 + 스킬
  ///
  List<TechSetEntity> selectedTechSets(WidgetRef ref) =>
      ref.watch(selectedTechSetsProvider);

  ///
  /// 유저 스킬 정보
  ///
  List<TechSetEntity> userSkillCollection(WidgetRef ref) {
    final skillItems = ref.watch(userInfoProvider).valueOrNull?.skills ?? [];
    return skillItems.map(TechSetEntity.skill).toList();
  }

  ///
  /// 유저 직군 정보
  ///
  List<TechSetEntity> userJobGroupCollection(WidgetRef ref) {
    final jobGroupItems =
        ref.watch(userInfoProvider).valueOrNull?.jobGroups ?? [];
    return jobGroupItems.map(TechSetEntity.jobGroup).toList();
  }
}
