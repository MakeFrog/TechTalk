import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/user.dart';

part 'is_bookmark_checked_provider.g.dart';

@riverpod
class IsBookmarkChecked extends _$IsBookmarkChecked {
  @override
  Future<bool> build(String contentId) async {
    final response = await userRepository.isContentBookMarked(contentId);
    return response.fold(
      onSuccess: (isMarked) => isMarked,
      onFailure: (e) {
        log('콘텐츠 북마크 정보 확인 실패 : ${e.toString()}');
        return false;
      },
    );
  }

  Future<void> toggle() async {
    await update((current) async {
      final response = await userRepository.updateBookMarkState(
        contentId: contentId,
        targetState: !current,
      );

      return response.fold(
        onSuccess: (_) {
          log('북마크 상태 업데이트 : ${!current}');
          return !current;
        },
        onFailure: (e) {
          log('북마크 상태 업데이트 실패 > $e');
          return current;
        },
      );
    });
  }
}
