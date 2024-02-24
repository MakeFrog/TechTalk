import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_state.g.dart';

@riverpod
class TestIntState extends _$TestIntState {
  @override
  List<int> build() {
    return [];
  }

  void addNew() {
    final aim = Random().nextInt(100);
    state = [aim, ...state];
  }
}
