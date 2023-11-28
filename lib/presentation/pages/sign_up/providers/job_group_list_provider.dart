import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/job/job.dart';

part 'job_group_list_provider.g.dart';

@riverpod
Future<JobGroupListEntity> jobGroupList(JobGroupListRef ref) async {
  final result = await getJobGroupsUseCase();

  return result.getOrThrow();
}
