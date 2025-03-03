import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';

part 'youtube_content_qna_provider.g.dart';

@Riverpod(dependencies: [youtubeDetailRouteArg])
class YoutubeContentQna extends _$YoutubeContentQna {
  @override
  Future<List<YoutubeQnaEntity>> build({
    required String contentId,
  }) async {
    final qnas = ref.read(youtubeDetailRouteArgProvider).qnas;
    if (qnas != null && qnas.isNotEmpty) {
      return qnas;
    }

    final response = await youtubeRepository.getQnas(contentId);
    return response.fold(
      onSuccess: (qnas) => qnas,
      onFailure: (e) {
        log('유튜브 콘텐츠 qna 정보 호출 실패 : $e');
        throw e;
      },
    );
  }

  void toggle(YoutubeQnaEntity qna) {
    update((prev) {
      final targetIndex = prev.indexWhere((e) => e.id == qna.id);
      if (targetIndex == -1) return prev; // 해당하는 항목이 없으면 변경 없음

      return [
        for (var i = 0; i < prev.length; i++)
          if (i == targetIndex)
            prev[i].copyWith(isSelected: !prev[i].isSelected)
          else
            prev[i]
      ];
    });
  }

  /// 모든 Qna 활성화
  void activateAll() {
    update((prev) {
      // 모든 Qna의 isSelected 값을 true로 변경한 새로운 리스트 생성
      return prev.map((qna) => qna.copyWith(isSelected: true)).toList();
    });
  }

  /// 선택된 Qna가 최소 한 개 이상인지 확인
  bool hasAtLeastOneSelected() {
    return state is AsyncData<List<YoutubeQnaEntity>> &&
        state.value!.any((qna) => qna.isSelected);
  }
}

// class YoutubeContentQnaNotifier extends ChangeNotifier {
//   List<YoutubeQnaEntity> selectedQnas;
//   AsyncValue<List<YoutubeQnaEntity>> qnas = const AsyncLoading();
// }
