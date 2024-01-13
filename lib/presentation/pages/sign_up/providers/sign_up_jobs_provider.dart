import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/job/job.dart';

part 'sign_up_jobs_provider.g.dart';

@riverpod
class SignUpJobs extends _$SignUpJobs {
  @override
  List<JobEntity> build() {
    return [];
  }

  void toggle(JobEntity item) {
    if (state.contains(item)) {
      state = state.toList()..remove(item);
    } else {
      state = state.toList()..add(item);
    }
  }

  void removeAt(int index) {
    state = state.toList()..removeAt(index);
  }
}
