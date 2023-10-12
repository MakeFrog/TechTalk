import 'package:techtalk/features/job/job.dart';

final class GetJobGroupListUseCase {
  const GetJobGroupListUseCase(
    this._jobRepository,
  );

  final JobRepository _jobRepository;

  Future<JobGroupListModel> call() async {
    return _jobRepository.getJobGroupList();
  }
}
