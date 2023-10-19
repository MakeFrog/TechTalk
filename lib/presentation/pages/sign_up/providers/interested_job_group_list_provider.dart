import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/job.dart';

part 'interested_job_group_list_provider.g.dart';

@riverpod
Future<JobGroupListModel> jobGroupList(JobGroupListRef ref) async {
  final getJobGroupListUseCase = locator<GetJobGroupListUseCase>();

  return getJobGroupListUseCase();
}

@riverpod
class InterestedJobGroupList extends _$InterestedJobGroupList {
  @override
  List<JobGroupModel> build() => [];

  void addGroup(JobGroupModel group) {
    state = [...state, group];
  }

  void removeGroup(int index) {
    final tempList = List.of(state)..removeAt(index);

    state = tempList;
  }
}
