import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/job.dart';

part 'job_group_list_provider.g.dart';

@riverpod
Future<JobGroupListModel> jobGroupList(JobGroupListRef ref) async {
  final getJobGroupListUseCase = locator<GetJobGroupListUseCase>();

  return getJobGroupListUseCase();
}
