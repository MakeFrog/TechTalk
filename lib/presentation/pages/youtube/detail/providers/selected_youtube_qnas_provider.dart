import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_content_qna_provider.dart';

part 'selected_youtube_qnas_provider.g.dart';

@riverpod
class SelectedYoutubeQnas extends _$SelectedYoutubeQnas {
  @override
  List<YoutubeQnaEntity> build(
    String contentId, {
    required List<YoutubeQnaEntity>? passedQnas,
  }) {
    if (passedQnas?.isNotEmpty ?? false) {
      return passedQnas!;
    }
    final qnas =
        ref.watch(youtubeContentQnaProvider(contentId)).value?.toList();

    return qnas ?? [];
  }

  void toggle(YoutubeQnaEntity qna) {
    final targetIndex = state.firstIndexWhereOrNull((e) => e.id == qna.id);
    if (targetIndex != null) {
      state = [...state]..removeAt(targetIndex);
    } else {
      state = [...state, qna];
    }
  }

  /// 모든 Qna 활성화
  void activateAll() {
    final qnas = ref.read(youtubeContentQnaProvider(contentId)).value?.toList();

    if (qnas?.length == state.length) return;

    state = qnas ?? [];
  }

  /// 선택된 Qna가 최소 한 개 이상인지 확인
  bool hasAtLeastOneSelected() {
    return state.isNotEmpty;
  }
}
