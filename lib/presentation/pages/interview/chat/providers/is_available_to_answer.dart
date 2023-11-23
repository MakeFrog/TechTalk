import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_available_to_answer.g.dart';

@Riverpod(keepAlive: true)
class IsAvailableToAnswer extends _$IsAvailableToAnswer {
  @override
  bool build() {
    return false;
  }

  void change({required bool isAvailable}) {
    state = isAvailable;
  }
}
