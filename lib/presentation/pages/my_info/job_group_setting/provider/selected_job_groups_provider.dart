import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'selected_job_groups_provider.g.dart';

@riverpod
class SelectedJobGroups extends _$SelectedJobGroups {
  @override
  List<JobGroup> build() {
    final userJobGroups = ref.read(userDataProvider).value!.jobGroups;
    ref.listen(userDataProvider, (previous, next) {
      print('@@현재 user Data Provider -> ${next}');
    });
    return userJobGroups;

    // return [JobGroup.WEB_DEVELOPER];
  }

  void add(JobGroup item) {
    state = [...state, item];
  }

  void remove(JobGroup item) {
    final removeList = state..remove(item);
    state = [...removeList];
  }
}
