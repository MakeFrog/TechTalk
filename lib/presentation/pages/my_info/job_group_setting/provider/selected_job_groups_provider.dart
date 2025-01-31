import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'selected_job_groups_provider.g.dart';

@riverpod
class SelectedJobGroups extends _$SelectedJobGroups {
  @override
  List<JobGroupEntity> build() {
    final userJobGroups = ref.read(userInfoProvider).value?.jobGroups ?? [];

    return userJobGroups.toList();
  }

  void add(JobGroupEntity item) {
    state = [...state, item];
  }

  void remove(JobGroupEntity item) {
    final removeList = state..remove(item);
    state = [...removeList];
  }
}
