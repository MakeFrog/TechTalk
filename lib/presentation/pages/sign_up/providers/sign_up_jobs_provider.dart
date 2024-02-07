import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/tech_set/data_source/remote/models/job_model.dart';

part 'sign_up_jobs_provider.g.dart';

@riverpod
class SignUpJobs extends _$SignUpJobs {
  @override
  List<Job> build() {
    return [];
  }

  void toggle(Job item) {
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
