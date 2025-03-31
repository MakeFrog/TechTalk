import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_bookmark_filter_provider.g.dart';

@Riverpod(keepAlive: true)
class StudyBookmarkFilter extends _$StudyBookmarkFilter {
  @override
  bool build() => false;

  void toggle() => state = !state;
}
