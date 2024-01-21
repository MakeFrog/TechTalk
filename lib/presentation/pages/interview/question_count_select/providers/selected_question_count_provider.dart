import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_question_count_provider.g.dart';

@riverpod
class SelectedQuestionCount extends _$SelectedQuestionCount {
  @override
  int build() {
    return 4; // 8개
  }

  void update(int count) {
    state = count;
    print('업데이트 됨 : ${state}');
  }

  static int defaultPlusCount = 4;
}
