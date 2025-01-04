import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_bookmark_checked_provider.g.dart';

@riverpod
class IsBookmarkChecked extends _$IsBookmarkChecked {
  @override
  Future<bool> build() async {
    return false;
  }

  void toggle() {
    update((current) => !current);
  }
}
